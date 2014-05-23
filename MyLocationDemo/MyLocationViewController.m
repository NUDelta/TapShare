//
//  MyLocationViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/4/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "MyLocationViewController.h"
#import "ReportsViewController.h"
#import "KnockViewController.h"

@interface MyLocationViewController ()
- (IBAction)getCurrentLocation:(id)sender;
- (IBAction)getCurrentLocation2:(id)sender;
- (IBAction)getCurrentLocation3:(id)sender;
- (IBAction)getCurrentLocation4:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *selfReport;
- (IBAction)getCurrentLocation5:(id)sender;
@end

@implementation MyLocationViewController {
    NSString *clickedEvent;
    KBKeyboardHandler *keyboard;
}

@synthesize selfReport;

- (void)viewDidLoad
{
    [super viewDidLoad];
    selfReport.delegate = self;
    keyboard = [[KBKeyboardHandler alloc] init];
    keyboard.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.selfReport resignFirstResponder];
    if([segue.identifier isEqualToString:@"pothole"])
    {
        KnockViewController *destViewController = (KnockViewController *)segue.destinationViewController;
        destViewController.eventName = clickedEvent;
    } else if ([segue.identifier isEqualToString:@"curb"])
    {
        KnockViewController *destViewController = (KnockViewController *)segue.destinationViewController;
        destViewController.eventName = clickedEvent;
    } else if ([segue.identifier isEqualToString:@"trash"])
    {
        KnockViewController *destViewController = (KnockViewController *)segue.destinationViewController;
        destViewController.eventName = clickedEvent;
    } else if ([segue.identifier isEqualToString:@"light"])
    {
        KnockViewController *destViewController = (KnockViewController *)segue.destinationViewController;
        destViewController.eventName = clickedEvent;
    } else if ([segue.identifier isEqualToString:@"custom"]) {
        KnockViewController *destViewController = (KnockViewController *)segue.destinationViewController;
        destViewController.eventName = clickedEvent;
    } else if ([segue.identifier isEqualToString:@"showReports"])
    {
        ReportsViewController *reportsViewController = (ReportsViewController *)segue.destinationViewController;
    }
}

- (IBAction)getCurrentLocation:(id)sender {
    clickedEvent = @"Pothole";
}

- (IBAction)getCurrentLocation2:(id)sender {
    clickedEvent = @"No Curb Ramp";
}


- (IBAction)getCurrentLocation3:(id)sender {
    clickedEvent = @"Full Trash Can";
}

- (IBAction)getCurrentLocation4:(id)sender {
    clickedEvent = @"Broken Street Light";
}

- (IBAction)selfReports:(id)sender {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)getCurrentLocation5:(id)sender {
    clickedEvent = selfReport.text;
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

/*- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.returnKeyType = UIReturnKeyDone;
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationBeginsFromCurrentState:YES];
	selfReport.frame = CGRectMake(selfReport.frame.origin.x, (selfReport.frame.origin.y - 100.0), selfReport.frame.size.width, selfReport.frame.size.height);
	[UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationBeginsFromCurrentState:YES];
	selfReport.frame = CGRectMake(selfReport.frame.origin.x, (selfReport.frame.origin.y + 100.0), selfReport.frame.size.width, selfReport.frame.size.height);
	[UIView commitAnimations];
}*/

@end
