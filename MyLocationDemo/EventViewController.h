//
//  EventViewController.h
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/10/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface EventViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) IBOutlet UILabel *latData;
@property (strong, nonatomic) IBOutlet UILabel *longData;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;




@end
