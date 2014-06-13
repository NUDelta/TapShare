//
//  MyLocationTableViewController.m
//  MyLocationDemo
//
//  Created by Stephen Chan on 5/16/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "MyLocationTableViewController.h"
#import <Parse/Parse.h>
#import "KnockViewController.h"
#import "MyLocationMapViewController.h"

@interface MyLocationTableViewController ()

@property (strong, nonatomic) NSArray *reportArray;
@property (strong, nonatomic) NSMutableArray *uniqueReportNames;
@property (strong, nonatomic) NSMutableArray *autocompleteNames;
@property (weak, nonatomic) IBOutlet UITextField *reportTextField;
@property (strong, nonatomic) NSString *customEvent;
@property (strong, nonatomic) NSString *selectedEvent;
@property (strong, nonatomic) KnockViewController *knockViewController;

@end

@implementation MyLocationTableViewController {
    
KBKeyboardHandler *keyboard;
    
}

static int REPORT = 0;
static int MAP = 1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.reportTextField.delegate = self;
    //keyboard = [[KBKeyboardHandler alloc] init];
    //keyboard.delegate = self;
    self.autocompleteNames = [[NSMutableArray alloc] init];
    self.reportTableView.delegate = self;
    self.reportTableView.dataSource = self;
    [NSThread detachNewThreadSelector:@selector(configureReports) toTarget:self withObject:nil];
    [self.reportMapSegmentControl addTarget:self
                         action:@selector(reportMapSegmentControlChanged)
               forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [NSThread detachNewThreadSelector:@selector(configureReports) toTarget:self withObject:nil];
    [self updateUI];
    self.reportMapSegmentControl.backgroundColor = [UIColor whiteColor];
    self.reportMapSegmentControl.tintColor = [UIColor blackColor];
}

-(void)configureReports
{
    PFQuery *query = [PFQuery queryWithClassName:@"Report"];
    [query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.reportArray = objects;
        NSMutableSet *uniqueReportSet = [[NSMutableSet alloc] init];
        // gather all the unique report names
        for (PFObject *report in self.reportArray) {
            NSString *event = report[@"event"];
            event = [event lowercaseString];
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
            NSString *normalizedString = [regex stringByReplacingMatchesInString:event options:0 range:NSMakeRange(0, [event length]) withTemplate:@" "];
            report[@"event"] = normalizedString;
            [uniqueReportSet addObject:normalizedString];
        }
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
        self.uniqueReportNames = [NSMutableArray arrayWithArray:[uniqueReportSet sortedArrayUsingDescriptors:@[sort]]];
        self.autocompleteNames = [NSMutableArray arrayWithArray:self.uniqueReportNames];
        if (self.reportTextField.text.length > 0) {
            [self searchAutocompleteEntriesWithSubstring:self.reportTextField.text];
        }
        [self.reportTableView reloadData];

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)customReportButtonPressed:(id)sender {
    self.customEvent = self.reportTextField.text;
    if ([self.uniqueReportNames containsObject:self.customEvent]) {
        NSLog(@"non-unique");
        // do nothing
    } else {
        [self.uniqueReportNames addObject:self.customEvent];
        [self.reportTableView reloadData];
    }
    //[self performSegueWithIdentifier:@"CustomReport" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( self.reportMapSegmentControl.selectedSegmentIndex == REPORT ) {
        
        KnockViewController *controller = (KnockViewController *)segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"PrepareToReport"]) {
            NSString *eventName = [self.autocompleteNames objectAtIndex:self.reportTableView.indexPathForSelectedRow.row];
            //NSLog(@"%@", eventName);
            controller.eventName = eventName;
        } else if ([segue.identifier isEqualToString:@"CustomReport"]) {
            controller.eventName = self.customEvent;
        }
        self.knockViewController = controller;
        
    } else if (self.reportMapSegmentControl.selectedSegmentIndex == MAP) {
        if ([segue.identifier isEqualToString:@"ViewMap"]) {
            MyLocationMapViewController *controller = (MyLocationMapViewController *)segue.destinationViewController;
            NSMutableArray *specificReportArray = [[NSMutableArray alloc] init];
            for (PFObject *report in self.reportArray) {
                if ([sender isEqualToString:report[@"event"]]) {
                    [specificReportArray addObject:report];
                }
            }
            controller.reportType = sender;
            controller.reportArray = specificReportArray;
        }
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.autocompleteNames = [NSMutableArray arrayWithArray:self.uniqueReportNames];
    [self.reportTableView reloadData];
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.autocompleteNames removeAllObjects];
    if (substring.length > 0) {
        for(NSString *curString in self.uniqueReportNames) {
            NSRange substringRange = [curString rangeOfString:substring];
            if (substringRange.location == 0) {
                [self.autocompleteNames addObject:curString];
            }
        }
    } else {
        self.autocompleteNames = [NSMutableArray arrayWithArray:self.uniqueReportNames];
    }
    if ([self.autocompleteNames count] == 0) {
        // follow along if no matches
        [self.autocompleteNames addObject:substring];
    }
    [self.reportTableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardSizeChanged:(CGSize)delta {
    CGRect frame = [self.view frame];
    frame.origin.y -= delta.height;
    self.view.frame = frame;
}

- (void)reportMapSegmentControlChanged
{
    [self updateUI];
}

- (void)updateUI
{
    
    if (self.reportMapSegmentControl.selectedSegmentIndex == REPORT) {
        self.titleText.text = @"Select something you want to track";
        self.reportTextField.placeholder = @"enter something to search or add";
    } else if (self.reportMapSegmentControl.selectedSegmentIndex == MAP) {
        self.titleText.text = @"Select something to see on the map";
        self.reportTextField.placeholder = @"enter something to search";
    }
    if ([self.selectedEvent length] > 0) {
        self.titleText.text = [NSString stringWithFormat:@"Currently Tracking: %@", self.selectedEvent];
    }
    [self.reportTableView reloadData];
}

#pragma mark - Table View Delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.reportMapSegmentControl.selectedSegmentIndex == REPORT) {
        if ([self.selectedEvent isEqualToString:self.autocompleteNames[indexPath.row]]) {
            if (self.knockViewController) {
                [self.knockViewController.theDetector.listener stopCollectingMotionInformation];
                [self.knockViewController stopTrackingLocation];
                self.selectedEvent = nil;
                [self updateUI];
                return;
            }
        }
        self.selectedEvent = self.autocompleteNames[indexPath.row];
        [self performSegueWithIdentifier:@"PrepareToReport" sender:self];
    } else if (self.reportMapSegmentControl.selectedSegmentIndex == MAP) {
        [self performSegueWithIdentifier:@"ViewMap" sender:self.autocompleteNames[indexPath.row]];
    }
}

#pragma mark - Table View Datasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportCell"];
    NSString *eventText = [self.autocompleteNames objectAtIndex:indexPath.row];
    cell.textLabel.text = eventText;
    cell.backgroundColor = [UIColor whiteColor];
    if (self.reportMapSegmentControl.selectedSegmentIndex == MAP) {
        int numberReports = 0;
        for (PFObject *report in self.reportArray) {
            if ([eventText isEqualToString:report[@"event"]]) {
                numberReports += 1;
            }
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Reports", numberReports];
    } else if (self.reportMapSegmentControl.selectedSegmentIndex == REPORT) {
        cell.detailTextLabel.text = @"Track This!";
        if ([eventText isEqualToString:self.selectedEvent]) {
            cell.backgroundColor = [UIColor colorWithRed:154.0/255 green:200.0/255 blue:255.0/255 alpha:1];
            cell.detailTextLabel.text = @"Stop Tracking";
        }
    }
    
    // highlight the current tracking item

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.autocompleteNames count];
}

@end
