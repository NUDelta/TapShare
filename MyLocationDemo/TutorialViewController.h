//
//  TutorialViewController.h
//  MyLocationDemo
//
//  Created by Nicole Zhu on 5/22/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *imageFile;
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@end
