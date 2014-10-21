//
//  TSPageViewController.m
//  TapShare
//
//  Created by Stephen Chan on 10/9/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "TSPageViewController.h"

@interface TSPageViewController ()

@property (strong, nonatomic) NSArray *viewControllerArray;

@end

@implementation TSPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIViewController *controllerOne = [[UIViewController alloc] init];
    UIViewController *controllerTwo = [[UIViewController alloc] init];
    UIViewController *controllerThree = [[UIViewController alloc] init];
    UIViewController *controllerFour = [[UIViewController alloc] init];
    self.viewControllerArray = @[controllerOne, controllerTwo, controllerThree, controllerFour];
    NSArray *startingArray = @[self.viewControllerArray[0]];
    [self setViewControllers:startingArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    index++;
    if (index > 3) {
        return nil;
    }
    return [self.viewControllers objectAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    index--;
    return [self.viewControllers objectAtIndex:index];   
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 1;
}


@end
