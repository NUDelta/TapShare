//
//  KBKeyboardHandler.h
//  CutTheCheese
//
//  Created by Danny Eiden on 4/19/14.
//  Copyright (c) 2014 NUventionWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBKeyboardHandlerDelegate;

@interface KBKeyboardHandler : NSObject

- (id)init;

@property(nonatomic, weak) id<KBKeyboardHandlerDelegate> delegate;
@property(nonatomic) CGRect frame;

@end
