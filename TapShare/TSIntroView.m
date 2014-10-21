//
//  TSIntroView.m
//  TapShare
//
//  Created by Stephen Chan on 10/10/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "TSIntroView.h"

@implementation TSIntroView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TSIntroView" owner:self options:nil] lastObject];
    }
    return self;
}

@end
