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
        MyLocationTableViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"homeView"];
        [(UINavigationController*)self.window.rootViewController pushViewController:ivc animated:NO];
    }
    
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
