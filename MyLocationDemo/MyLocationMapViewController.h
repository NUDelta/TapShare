//
//  MyLocationMapViewController.h
//  MyLocationDemo
//
//  Created by Stephen Chan on 5/20/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface MyLocationMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *reportArray; // of PFObject
@property (weak, nonatomic) IBOutlet UISegmentedControl *myReportSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *everyoneElseSegmentControl;

@end
