//
//  TSTutorialViewController.m
//  TapShare
//
//  Created by Stephen Chan on 10/9/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "TSTutorialViewController.h"
#import "TSDemoView.h"

@interface TSTutorialViewController ()

@end

@implementation TSTutorialViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([self.pageIndex integerValue] == 2) {
        TSTutorialNavigationViewController *navigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        [self presentViewController:navigationViewController animated:NO completion:nil];
        return;
    }
    [super viewDidAppear:animated];
}

@end
