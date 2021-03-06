//
//  KnockViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/18/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "KnockViewController.h"
#import "SubmitViewController.h"

@interface KnockViewController ()

@end

@implementation KnockViewController {
    CLLocationManager *locationManager;
    NSString *clickedEvent;
}
@synthesize reportType;
@synthesize eventName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    self.theDetector = [[knockDetector alloc] init];
    self.theDetector.delegate = self;
    [self.theDetector.listener collectMotionInformationWithInterval:(10)];
    NSLog(@"started knock detection");
}

- (void)stopTrackingLocation
{
    [locationManager stopUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(void){}];
    [locationManager startUpdatingLocation];
    
    reportType.text = [NSString stringWithFormat:@"Now Tracking: %@", eventName];
    clickedEvent = eventName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)detectorDidDetectKnock:(knockDetector*) detector
{
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    NSLog(@"Did detect knock");
    
    
    //[self performSegueWithIdentifier:@"reportSuccess" sender:self];
    [self saveReport];
    
    NSLog(@"Latitude: %f", latitude);
    NSLog(@"Longitude: %f", longitude);
    NSLog(@"Event: %@", clickedEvent);
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"You reported: %@", self.eventName];
    notification.soundName = @"short_double_low.wav";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    /*CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    PFObject *report = [PFObject objectWithClassName:@"Report"];
    report[@"event"] = [NSString stringWithFormat:@"%@", clickedEvent];
    report[@"location"] = geoPoint;
    NSLog(@"saved: %@", report);
    [report saveInBackground];*/
    /*[report saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"saved successfully");
        } else {
            NSLog(@"error: didn't save");
        }
    }];*/
}

- (void)saveReport
{
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    PFObject *report = [PFObject objectWithClassName:@"Report"];
    report[@"event"] = [NSString stringWithFormat:@"%@", clickedEvent];
    report[@"location"] = geoPoint;
    report[@"userID"] = [[PFUser currentUser] objectId];
    report[@"userName"] = [[PFUser currentUser] objectForKey:@"name"];
    NSLog(@"%@", report);
    [report saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
     if (!error) {
         NSLog(@"saved successfully");
         //NSLog(@"%@", report);
     } else {
         NSLog(@"error: didn't save");
     }
     }];
    
    /*CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    PFObject *report = [PFObject objectWithClassName:@"Report"];
    [report setObject:geoPoint forKey:@"location"];
    [report setObject:clickedEvent forKey:@"event"];
    //report[@"event"] = [NSString stringWithFormat:@"%@", clickedEvent];
    //report[@"location"] = geoPoint;
    NSLog(@"saved: %@", report);
    [report saveInBackground];*/
}

- (void) viewWillDisappear:(BOOL)animated
{
    //[self.theDetector.listener stopCollectingMotionInformation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
}
@end
