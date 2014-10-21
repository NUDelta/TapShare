//
//  TSIntroView.m
//  TapShare
//
//  Created by Stephen Chan on 10/9/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "TSDemoView.h"

@interface TSDemoView()

@property (weak, nonatomic) IBOutlet UIButton *replayButton;

@end

@implementation TSDemoView

+(NSString *)demoVideoURL
{
    return @"demoVideo";
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TSDemoView" owner:self options:nil] lastObject];
        [self playDemo];
    }
    return self;
}

- (IBAction)replayButtonTouched:(id)sender {
    /* find all player layers and remove them */
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[AVPlayerLayer class]]) {
            AVPlayerLayer *playerLayer = (AVPlayerLayer *)layer;
            [playerLayer.player seekToTime:kCMTimeZero];
            [playerLayer.player play];
        }
    }
}


-(void)playDemo
{
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:[TSDemoView demoVideoURL] withExtension:@"mp4"];
    AVAsset *avAsset = [AVAsset assetWithURL:videoURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    AVPlayer *avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:avPlayer];
    [avPlayerLayer setFrame:self.frame];
    [self.layer addSublayer:avPlayerLayer];
    [avPlayer seekToTime:kCMTimeZero];
    [avPlayer setMuted:NO];
    [avPlayer setVolume:1];
    [avPlayer play];
}

@end
