//
//  MyLocationAppDelegate.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/4/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "MyLocationAppDelegate.h"
#import "MyLocationLoginViewController.h"
#import "MyLocationTableViewController.h"
#import <Parse/Parse.h>

@implementation MyLocationAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"zkStIiBgvGoBkJrSUd2tTrgO4wYG8hPdvhyeCxj2"
                  clientKey:@"ffLZCqCLe1wzlMKoX6qoBOeFExENIMhRqQHcANA3"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    // Override point for customization after application launch.
    if ([PFUser currentUser] && [[PFUser currentUser] isAuthenticated]) {
        NSLog(@"%@", [PFUser currentUser]);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MyLocationTableViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
        [(UINavigationController*)self.window.rootViewController pushViewController:homeViewController animated:NO];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TSTutorialRootViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Tutorial"];
        self.window.rootViewController = rootViewController;
    }
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    [self retrieveToolTipInfo];
    
    return YES;
}
     
-(void)retrieveToolTipInfo
{
    NSDictionary *toolTipDictionary = [self dictionaryFromPlist:@"ToolTipAlerts"];
    self.toolTipsDisabled = [[toolTipDictionary objectForKey:@"ToolTipsDisabled"] boolValue];
    self.toolTipArray = [NSMutableArray arrayWithArray:[toolTipDictionary objectForKey:@"ToolTipArray"]];
}

-(NSDictionary *)dictionaryFromPlist:(NSString *)plistName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath isDirectory:NO]) {
        return [[NSDictionary alloc] initWithContentsOfFile:filePath];
    }
    else {
        return nil;
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIBackgroundTaskIdentifier bgTask = 0;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:bgTask];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
