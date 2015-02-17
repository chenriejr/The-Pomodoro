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
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@end

@implementation POTimerViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotifications];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.title = @"Pomodoro Timer";
    self.pauseButton.enabled = NO;
    [self updateTimerLabel];


}
- (IBAction)pauseButtonPressed:(UIButton *)sender {
    
    [POTimer sharedInstance].isOn = NO;
    self.pauseButton.enabled = NO;
    self.timerButton.enabled = YES;
}

- (IBAction)timerButtonPressed:(id)sender {
    self.timerButton.enabled = NO;
    [[POTimer sharedInstance] startTimer];
    self.pauseButton.enabled = YES;
}

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:currentRoundNotifciation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:TimerCompleteNotification object:nil];

    
}


-(void)updateTimerLabel {
    self.timerLabel.text = [NSString stringWithFormat: @"%ld:%02ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

-(void)newRound{
    [self updateTimerLabel];
    self.timerButton.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
