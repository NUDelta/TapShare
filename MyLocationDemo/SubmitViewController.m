//
//  SubmitViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/18/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "SubmitViewController.h"

@interface SubmitViewController ()

@end

@implementation SubmitViewController
@synthesize eventTitle;
@synthesize latData;
@synthesize longData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:3.0
                                               target:self
                                             selector:@selector(timerFireMethod:)
                                             userInfo:nil
                                              repeats: YES];
    
    [[NSRunLoop mainRunLoop] addTimer: myTimer
                              forMode: NSDefaultRunLoopMode];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"Report"];
    [query orderByDescending:@"createdAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *submitted, NSError *error) {
        NSString *event = submitted[@"event"];
        eventTitle.text = [NSString stringWithFormat:@"Reported: %@", event];
        PFGeoPoint *geoPoint = [submitted objectForKey:@"location"];
        double lat = geoPoint.latitude;
        double lon = geoPoint.longitude;
        latData.text = [NSString stringWithFormat:@"Latitude: %f", lat];
        longData.text = [NSString stringWithFormat:@"Longitude: %f", lon];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)timerFireMethod:(NSTimer *)timer
{
    // Whatever the segue is called to your second view controller. Don't forget to set it in your storyboard ;)
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
