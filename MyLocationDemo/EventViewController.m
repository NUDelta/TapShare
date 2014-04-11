//
//  EventViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/10/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController {
    CLLocationManager *locationManager;
}
@synthesize eventTitle;
@synthesize eventName;
@synthesize latData;
@synthesize longData;
@synthesize mapView;

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
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
	// Do any additional setup after loading the view.
    eventTitle.text = eventName;
    latData.text = [NSString stringWithFormat:@"Latitude: %g", latitude];
    longData.text = [NSString stringWithFormat:@"Longitude: %g", longitude];

    self.mapView.delegate = self;
    self.mapView.userTrackingMode = YES;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = eventName;
    point.subtitle = [NSString stringWithFormat:@"Latitude: %g, Longitude: %g", point.coordinate.latitude, point.coordinate.longitude];
    
    [self.mapView addAnnotation:point];
    NSLog(@"Annotation added");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"returnHome"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
