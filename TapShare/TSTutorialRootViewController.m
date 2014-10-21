//
//  TSTSTutorialRootViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 5/22/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "TSTutorialRootViewController.h"

@interface TSTutorialRootViewController ()


@end

@implementation TSTutorialRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPageViewController];
   
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

-(void)initPageViewController
{
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    TSTutorialViewController *startingViewController = (TSTutorialViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 10);
 
}

- (IBAction)startWalkthrough:(id)sender {
    TSTutorialViewController *startingViewController = (TSTutorialViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0: {
            TSTutorialViewController *tutorialViewController = (TSTutorialViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
            [tutorialViewController.view addSubview:[[TSIntroView alloc] initWithFrame:self.view.frame]];
            tutorialViewController.pageIndex = [NSNumber numberWithUnsignedInteger:index];
            return tutorialViewController;
        }
        case 1: {
             TSTutorialViewController *tutorialViewController = (TSTutorialViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
            [tutorialViewController.view addSubview:[[TSDemoView alloc] initWithFrame:self.view.frame]];
            tutorialViewController.pageIndex = [NSNumber numberWithUnsignedInteger:index];
            return tutorialViewController;           
        }
        case 2: {
            TSTutorialViewController *tutorialViewController = (TSTutorialViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
            tutorialViewController.pageIndex = [NSNumber numberWithUnsignedInteger:index];
            return tutorialViewController;                      
        }
        default:
            return nil;
            break;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = 0;
    if ([viewController respondsToSelector:@selector(pageIndex)]) {
        NSNumber *pageIndex = (NSNumber *)[viewController performSelector:@selector(pageIndex) withObject:nil];
        index = [pageIndex integerValue];
    }
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = 3;
    if ([viewController respondsToSelector:@selector(pageIndex)]) {
        NSNumber *pageIndex = (NSNumber *)[viewController performSelector:@selector(pageIndex) withObject:nil];
        index = [pageIndex integerValue];
    }   
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;

    if (index == 3) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
@end
