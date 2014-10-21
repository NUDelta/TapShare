//
//  TSTutorialRootViewController.h
//  MyLocationDemo
//
//  Created by Nicole Zhu on 5/22/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TSTutorialViewController.h"
#import "TSDemoView.h"
#import "TSIntroView.h"
#import "MyLocationLoginViewController.h"
#import "TSTutorialNavigationViewController.h"

@interface TSTutorialRootViewController : UIViewController <UIPageViewControllerDataSource>
- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;


@end
