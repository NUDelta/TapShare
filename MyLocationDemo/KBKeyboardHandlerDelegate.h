//
//  KBKeyboardHandlerDelegate.h
//  CutTheCheese
//
//  Created by Danny Eiden on 4/19/14.
//  Copyright (c) 2014 NUventionWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBKeyboardHandlerDelegate

- (void)keyboardSizeChanged:(CGSize)delta;

@end

@interface KBKeyboardHandlerDelegate : NSObject

@end
