//
//  POAppearanceController.m
//  The Pomodoro
//
//  Created by Parker Rushton on 2/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POAppearanceController.h"
#import "PORoundsViewController.h"
#import "POTimer.h"
#import "POTimerViewController.h"

@implementation POAppearanceController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (void)setUpAppearance {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.866 green:0.302 blue:0.000 alpha:0.100]];
     [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
}

@end
