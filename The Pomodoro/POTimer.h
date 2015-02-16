//
//  POTimer.h
//  The Pomodoro
//
//  Created by Jake Herrmann on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const TimerCompleteNotification;
extern NSString * const SecondTickNotification;

@interface POTimer : NSObject
+(POTimer *)sharedInstance;
@property (nonatomic, assign) NSInteger *minutes;
@property (nonatomic, assign) NSInteger *seconds;
@property (nonatomic, assign) BOOL isOn;

-(void)startTimer;
-(void)cancelTimer;
@end
