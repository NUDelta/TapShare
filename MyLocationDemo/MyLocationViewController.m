//
//  MyLocationViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/4/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "MyLocationViewController.h"
#import "EventViewController.h"

@interface MyLocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventValue;
- (IBAction)getCurrentLocation:(id)sender;
- (IBAction)getCurrentLocation2:(id)sender;
- (IBAction)getCurrentLocation3:(id)sender;
- (IBAction)getCurrentLocation4:(id)sender;
@end

@implementation MyLocationViewController {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *clickedEvent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];

    NSString *clickEvent = @"saw a pothole";
    clickedEvent = @"Pothole";
    _eventValue.text = [NSString stringWithFormat:@"%@", clickEvent];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showEventDetail"])
    {
        EventViewController *destViewController = (EventViewController *)segue.destinationViewController;
        destViewController.eventName = [NSString stringWithFormat:@"Reported: %@", clickedEvent];
    } else if ([segue.identifier isEqualToString:@"showEventDetail2"])
    {
        EventViewController *destViewController = (EventViewController *)segue.destinationViewController;
        destViewController.eventName = [NSString stringWithFormat:@"Reported: %@", clickedEvent];
    } else if ([segue.identifier isEqualToString:@"showEventDetail3"])
    {
        EventViewController *destViewController = (EventViewController *)segue.destinationViewController;
        destViewController.eventName = [NSString stringWithFormat:@"Reported: %@", clickedEvent];
    } else if ([segue.identifier isEqualToString:@"showEventDetail4"])
    {
        EventViewController *destViewController = (EventViewController *)segue.destinationViewController;
        destViewController.eventName = [NSString stringWithFormat:@"Reported: %@", clickedEvent];
    }
}

- (IBAction)getCurrentLocation2:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    clickedEvent = @"No Curb Ramp";
    NSString *clickEvent = @"no curb ramp";
    _eventValue.text = [NSString stringWithFormat:@"%@", clickEvent];
}


- (IBAction)getCurrentLocation3:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    clickedEvent = @"Full Trash Can";
    NSString *clickEvent = @"full trash can";
    _eventValue.text = [NSString stringWithFormat:@"%@", clickEvent];
}

- (IBAction)getCurrentLocation4:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    clickedEvent = @"Broken Street Light";
    NSString *clickEvent = @"broken street light";
    _eventValue.text = [NSString stringWithFormat:@"%@", clickEvent];
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
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        double dblLatitude = currentLocation.coordinate.latitude;
        double dblLongitude = currentLocation.coordinate.longitude;
        
        _latitudeLabel.text = [NSString stringWithFormat:@"%g", dblLatitude];
        _longitudeLabel.text = [NSString stringWithFormat:@"%g", dblLongitude];
        
        /*PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
        testObject[@"foo"] = @"bar";
        [testObject saveInBackground];*/
    }
}
@end
