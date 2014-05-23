//
//  MyLocationMapViewController.m
//  MyLocationDemo
//
//  Created by Stephen Chan on 5/20/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "MyLocationMapViewController.h"

@interface MyLocationMapViewController ()

@property (strong, nonatomic) NSMutableArray *myReportArray;
@property (strong, nonatomic) NSMutableArray *everyoneElseReportArray;

@end

@implementation MyLocationMapViewController

static int SHOW = 0;
static int HIDE = 1;

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
    self.mapView.delegate = self;
    NSLog(@"%@", [PFUser currentUser]);
    self.myReportArray = [[NSMutableArray alloc] init];
    self.everyoneElseReportArray = [[NSMutableArray alloc] init];
    [self divideReports];
    [self updateUI];
    [self.myReportSegmentControl addTarget:self
                                     action:@selector(updateUI)
                           forControlEvents:UIControlEventValueChanged];
    [self.everyoneElseSegmentControl addTarget:self
                                    action:@selector(updateUI)
                          forControlEvents:UIControlEventValueChanged];
}

- (void)updateUI
{
    [self.mapView removeAnnotations:self.mapView.annotations];

    while ([self.mapView.annotations count] > 0) {
        // Allow the run loop to do some processing of the stream
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    if (self.myReportSegmentControl.selectedSegmentIndex == SHOW) {
        [self annotateMap:self.myReportArray withType:@"myReport"];
    }
    if (self.everyoneElseSegmentControl.selectedSegmentIndex == SHOW) {
        [self annotateMap:self.everyoneElseReportArray withType:@"everyoneElseReport"];
    }
}

- (void)divideReports
{
    for (PFObject *report in self.reportArray) {
        if ([report[@"userID"] isEqualToString:[[PFUser currentUser] objectId]]) {
            [self.myReportArray addObject:report];
        } else {
            [self.everyoneElseReportArray addObject:report];
        }
    }
}

- (void)annotateMap:(NSArray *)annotations withType:(NSString *)type
{
    for (PFObject *report in annotations) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D annotationCoord;
        PFGeoPoint *geoPoint = report[@"location"];
        annotationCoord.latitude = geoPoint.latitude;
        annotationCoord.longitude = geoPoint.longitude;
        //MKPinAnnotationView *pinAnnotation = [self returnPointView:annotationCoord andTitle:@"Report" andColor:color];
        annotation.coordinate = annotationCoord;
        annotation.title = type;
        [self.mapView addAnnotation:annotation];
        [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(annotationCoord.latitude, annotationCoord.longitude), MKCoordinateSpanMake(0.025, 0.025))];
        [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MKPointAnnotation *)annotation
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    if ([annotation.title isEqualToString:@"myReport"]) {
        annotationView.pinColor = MKPinAnnotationColorPurple;
    } else {
        annotationView.pinColor = MKPinAnnotationColorGreen;
    }
    annotationView.animatesDrop = YES;
    return annotationView;
}

/*- (MKPinAnnotationView *)returnPointView: (CLLocationCoordinate2D) location andTitle: (NSString*) title andColor: (int) color
{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    MKPinAnnotationView *annotationPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Nil];
    [annotation setCoordinate:location];
    annotation.title = title;
    annotationPin.pinColor = color;
    return annotationPin;
}*/

- (void)myReportSwitchChanged
{
    [self updateUI];
}

- (void)everyoneElseSwitchChanged
{
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
