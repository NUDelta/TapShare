//
//  SubmitViewController.h
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/18/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SubmitViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *latData;
@property (strong, nonatomic) IBOutlet UILabel *longData;
@end
