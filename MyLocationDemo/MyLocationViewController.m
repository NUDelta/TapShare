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
@end

@implementation MyLocationViewController {
    NSString *clickedEvent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
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
@end
