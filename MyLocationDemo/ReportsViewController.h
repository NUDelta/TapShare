//
//  ReportsViewController.h
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/17/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface ReportsViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *numPothole;
@property (strong, nonatomic) IBOutlet UILabel *numCurb;
@property (strong, nonatomic) IBOutlet UILabel *numTrash;
@property (strong, nonatomic) IBOutlet UILabel *numLight;

@end
