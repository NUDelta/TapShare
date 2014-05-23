//
//  knockDetector.m
//  LocaleNatives
//
//  Created by Stephen Chan on 4/17/14.
//  Copyright (c) 2014 Stephen Chan. All rights reserved.
//

#import "knockDetector.h"
#import <Parse/Parse.h>

@implementation knockDetector

-(instancetype)init
{
    self = [super init];
    if (self) {
        jerk = 0;
        self.listener = [[coreMotionListener alloc] init];
        self.listener.delegate = self;
        [self setFilterConstantWithSampleRate:0.01 cutoffFrequency:6];
    }
    return self;
}

double normAll(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z);
}

-(void)motionListener:(coreMotionListener *)listener didReceiveDeviceMotion:(CMDeviceMotion *)deviceMotion
{
    //[self.filterAccel setFilterConstantWithSampleRate:[listener.measurementInterval floatValue] cutoffFrequency:60];
    //NSLog(@"got a device motion");
    /*currentDeviceMotion = deviceMotion;
     CMAcceleration accel = deviceMotion.userAcceleration;
     float normedAccel = normAll( accel.x, accel.y, accel.z );
     CMAcceleration lastAccel = lastDeviceMotion.userAcceleration;
     float lastNormedAccel = normAll( lastAccel.x, lastAccel.y, lastAccel.z);
     float newJerk = fabsf(lastNormedAccel - normedAccel) / [listener.measurementInterval floatValue];
     jounce = fabsf(jerk - newJerk) / [listener.measurementInterval floatValue];
     jerk = newJerk;
     lastDeviceMotion = deviceMotion;
     CMRotationRate rotation = deviceMotion.rotationRate;
     float normedRotation = normAll(rotation.x, rotation.y, rotation.z);*/
    //NSLog(@"%f", normedRotation);
    //NSLog(@"%f", jounce);
    [self processDeviceMotion:deviceMotion withListener:listener filter:@"highPass"];
    if ([self satisfiesDoubleKnock]) {
        //NSLog(@"%f", jounce);
        //NSLog(@"%f", jerk);
        //NSLog(@"%f", normedAccel);
        //NSLog(@"%f", normedRotation);
        NSLog(@"%f", deviceMotion.gravity.z);
        lastDoubleKnock = deviceMotion.timestamp;
        timeFromFirstKnock = [NSNumber numberWithFloat:fabsf(deviceMotion.timestamp - lastKnockTime)];
        [self.delegate detectorDidDetectKnock:self];
        //[self saveKnockRecord];
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"hi";
        notification.soundName = @"FFLife1.mp3";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
        NSLog(@"got a new knock");
        
    }
    if ([self satisfiesKnockThresholds]) {
        NSLog(@"%f", jounce);
        NSLog(@"%f", jerk);
        NSLog(@"%f", normedAccel);
        NSLog(@"%f", normedRotation);
        lastKnockTime = deviceMotion.timestamp;
        //NSLog(@"got a new knock");
    } else if (fabsf(deviceMotion.timestamp - lastKnockTime) > 1) {
    }
}

- (void)processDeviceMotion:(CMDeviceMotion *)deviceMotion withListener:(coreMotionListener *)listener filter:(NSString *)filter
{
    // setting accel
    currentDeviceMotion = deviceMotion;
    CMAcceleration accel = [self HighPassAccelerationFromDeviceMotion:deviceMotion];
    /* if ([self.filterAccel lastX]) {
     if([filter isEqualToString:@"highPass"]) {
     accel = [self.filterAccel HighPassAccelerationFromDeviceMotion:deviceMotion];
     } else if ([filter isEqualToString:@"lowPass"]) {
     accel = [self.filterAccel LowPassAccelerationFromDeviceMotion:deviceMotion];
     } else {
     accel = deviceMotion.userAcceleration;
     }
     } else {
     [self.filterAccel setLastX:deviceMotion.userAcceleration.x];
     [self.filterAccel setLastY:deviceMotion.userAcceleration.y];
     [self.filterAccel setLastZ:deviceMotion.userAcceleration.z];
     //accel = deviceMotion.userAcceleration;
     }*/
    
    
    normedAccel = normAll( accel.x, accel.y, accel.z );
    // setting last accel
    //CMAcceleration lastAccel = lastDeviceMotion.userAcceleration;
    float lastNormedAccel = normAll( lastAccel.x, lastAccel.y, lastAccel.z);
    // setting jerk
    float newJerk = fabsf(lastNormedAccel - normedAccel) / [listener.measurementInterval floatValue];
    // set rotation
    CMRotationRate rotation = currentDeviceMotion.rotationRate;
    normedRotation = normAll( rotation.x, rotation.y, rotation.z );
    // set jounce
    jounce = fabsf(jerk - newJerk) / [listener.measurementInterval floatValue];
    // set jerk
    jerk = newJerk;
    // set lastDeviceMotion
    lastDeviceMotion = deviceMotion;
    lastAccel = accel;
    gravity = deviceMotion.gravity;
}

- (BOOL)satisfiesKnockThresholds
{
    float lastDoubleKnockTimeDifference = fabsf(currentDeviceMotion.timestamp - lastDoubleKnock);
    float lastKnockTimeDifference = fabsf(currentDeviceMotion.timestamp - lastKnockTime);
    //return jounce > 2 && jerk > .01 && normedAccel < 0.01 && normedRotation < 1 && lastDoubleKnockTimeDifference > 1 && lastKnockTimeDifference > 0.1;
    //float total = (jounce * 0.33) + (jerk * 9.94) - (normedRotation * 0.84) + (normedAccel * 548.18) - 1.51;
    float total = -0.42 + (normedAccel * 296.13) - (jounce * 0.02);
    float odds = 1 / (1 + exp(-total));
    if (odds > 0.999) {
        NSLog(@"%f", odds);
    }
    return ((odds > 0.6) || [self satisfiesTableKnockThresholds]) && lastDoubleKnockTimeDifference > 1 && lastKnockTimeDifference > 0.15 && normedAccel < 0.008;
}

- (BOOL)satisfiesTableKnockThresholds
{
    float lastDoubleKnockTimeDifference = fabsf(currentDeviceMotion.timestamp - lastDoubleKnock);
    float lastKnockTimeDifference = fabsf(currentDeviceMotion.timestamp - lastKnockTime);
    //return jounce > 2 && jerk > .01 && normedAccel < 0.01 && normedRotation < 1 && lastDoubleKnockTimeDifference > 1 && lastKnockTimeDifference > 0.1;
    float total = (jounce * 0.45) + (normedRotation * -0.86) + (jerk * 8.92) - 0.67;
    float odds = 1 / (1 + exp(-total));
    if (odds > 0.85) {
        NSLog(@"%f", odds);
    }
    return odds > 1.85 && lastDoubleKnockTimeDifference > 1 && lastKnockTimeDifference > 0.15 && fabsf(gravity.z) > 0.99;
}

- (BOOL)satisfiesDoubleKnock
{
    float lastKnockTimeDifference = fabsf(currentDeviceMotion.timestamp - lastKnockTime);
    return [self satisfiesKnockThresholds] && lastKnockTimeDifference > 0.1 && lastKnockTimeDifference < 0.5;
}

- (void)setFilterConstantWithSampleRate:(double)rate cutoffFrequency:(double)freq
{
    double dt = 1.0 / rate;
    double RC = 1.0 / freq;
    filterConstant = RC / (dt + RC);
}

#define kAccelerometerMinStep				0.02
#define kAccelerometerNoiseAttenuation		3.0

- (CMAcceleration)HighPassAccelerationFromDeviceMotion:(CMDeviceMotion *)DM
{
    // takes a CMDeviceMotion and returns it as a CMAcceleration struct
    
	double alpha = filterConstant;
	BOOL adaptive = NO;
	if (adaptive)
	{
		/*float d = Clamp(fabs(normAll(x, y, z) - normAll(DM.userAcceleration.x, DM.userAcceleration.y, DM.userAcceleration.z)) / kAccelerometerMinStep - 1.0, 0.0, 1.0);
         alpha = d * filterConstant / kAccelerometerNoiseAttenuation + (1.0 - d) * filterConstant;*/
	}
	
	x = alpha * (x + DM.userAcceleration.x - lastX);
	y = alpha * (y + DM.userAcceleration.y - lastY);
	z = alpha * (z + DM.userAcceleration.z - lastZ);
	
	lastX = DM.userAcceleration.x;
	lastY = DM.userAcceleration.y;
	lastZ = DM.userAcceleration.z;
    
    CMAcceleration acceleration;
    acceleration.x = x;
    acceleration.y = y;
    acceleration.z = z;
    return acceleration;
}

@end
