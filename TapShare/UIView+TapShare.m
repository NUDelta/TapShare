//
//  UIView+TapShare.m
//  TapShare
//
//  Created by Stephen Chan on 10/10/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "UIView+TapShare.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIView (TapShare)

-(void)setShouldAnimate:(BOOL)shouldAnimate
{
    return objc_setAssociatedObject(self, @selector(shouldAnimate), [NSNumber numberWithBool:shouldAnimate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)shouldAnimate
{
    return [objc_getAssociatedObject(self, @selector(shouldAnimate)) boolValue];
}

-(void)setToolTipDisplaying:(NSNumber *)toolTipDisplaying
{
    return objc_setAssociatedObject(self, @selector(toolTipDisplaying), toolTipDisplaying, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)toolTipDisplaying
{
    return objc_getAssociatedObject(self, @selector(toolTipDisplaying));
}

-(void)beginToolTipAnimation:(TSAnimationDirection)direction
{
    UIView *backgroundView;
    if (!self.toolTipDisplaying) {
        //backgroundView = [[UIView alloc] initWithFrame:self.frame];
        //[self addSubview:backgroundView];
        //self.layer.anchorPointZ = 0;
        //backgroundView.layer.anchorPointZ = 1000;
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trackingToolTipTapped:)];
        [self addGestureRecognizer:gestureRecognizer];
        self.toolTipDisplaying = [NSNumber numberWithBool:YES];
        //self.backgroundColor = [UIColor clearColor];
    }
    if (self.shouldAnimate == NO) {
        for (UIView *subview in self.subviews) {
            if (subview == backgroundView) {
                [subview removeFromSuperview];
            }
        }
        return;
    }
    self.backgroundColor = [UIColor clearColor];
    if (direction == TSAnimationForward) {
        [UIView animateWithDuration:1.0 animations:^{
            //backgroundView.backgroundColor = [UIColor redColor];
            self.layer.backgroundColor = [UIColor redColor].CGColor;
        } completion:^(BOOL finished) {
            if (finished) {
                [self beginToolTipAnimation:TSAnimationBackward];
            }
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            //backgroundView.backgroundColor = [UIColor whiteColor];
            self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        } completion:^(BOOL finished) {
            if (finished) {
                [self beginToolTipAnimation:TSAnimationForward];
            }
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.toolTipDisplaying) {
        NSLog(@"bring it up!");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"blah" message:@"hi" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        self.toolTipDisplaying = [NSNumber numberWithBool:NO];
    }
}

-(void)endToolTipAnimation
{
    self.shouldAnimate = YES;
}

@end
