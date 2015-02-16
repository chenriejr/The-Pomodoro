//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Jake Herrmann on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "POTimer.h"

@interface POTimerViewController ()

@end

@implementation POTimerViewController

-(instancetype)init {
   self = [super init];
    if (self) {
        [self registerForNotifications];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}

- (IBAction)timerButtonPressed:(id)sender {
}

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:SecondTickNotification object:nil];
}

-(void)updateTimerLabel {
    self.timerLabel.text = [NSString stringWithFormat: @"%ld:%02ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
