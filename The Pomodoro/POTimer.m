//
//  POTimer.m
//  The Pomodoro
//
//  Created by Jake Herrmann on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimer.h"
NSString * const TimerCompleteNotification = @"timerComplete";
NSString * const SecondTickNotification = @"secondTick";

@implementation POTimer
+ (POTimer*)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POTimer new];
    });
    
    return sharedInstance;
}

-(void)startTimer {
    self.isOn = YES;
    [self isActive];
}

-(void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
}

-(void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil];
}

-(void)decreaseSecond {
    if (self.seconds > 0) {
        self.seconds--;
    }
    if (self.minutes > 0) {
        if (self.seconds == 0) {
            self.seconds = 59;
            self.minutes--;
        }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    }else {
        if (self.seconds == 0) {
            [self endTimer];
        }
    }
}

-(void)isActive {
    if (self.isOn == YES) {
        [self decreaseSecond];
    }
}
@end
