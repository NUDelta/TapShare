//
//  KnockViewController.h
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/18/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioServices.h>
#import <Parse/Parse.h>
#import "knockDetector.h"

@interface KnockViewController : UIViewController<KnockDetectorDelegate, CLLocationManagerDelegate>
- (void)knockDetectorDidDetect:(knockDetector*) detector;
@property knockDetector *theDetector;
@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) IBOutlet UILabel *reportType;
- (void)saveReport;
@end
