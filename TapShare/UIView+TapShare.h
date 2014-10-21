//
//  UIView+TapShare.h
//  TapShare
//
//  Created by Stephen Chan on 10/10/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TSAnimDirection {
    TSAnimationForward,
    TSAnimationBackward
} TSAnimationDirection;

@interface UIView (TapShare)

@property BOOL shouldAnimate;
@property (strong, nonatomic) NSNumber *toolTipDisplaying;

-(void)beginToolTipAnimation:(TSAnimationDirection)direction;
-(void)endToolTipAnimation;
-(void)trackingToolTipTapped: (UIGestureRecognizer *)gestureRecognizer;

@end
