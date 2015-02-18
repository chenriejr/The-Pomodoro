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
	[self.pauseButton setHidden:YES];
    [self updateTimerLabel];
	
	//Call setup Alert method when timer runs out
	if ([POTimer sharedInstance].minutes == 0 && [POTimer sharedInstance].seconds == 0) {
		[self setupAlert];
	}


}

- (void)setUpNotification{
	UILocalNotification *localNotification = [UILocalNotification new];
	NSDate *fireDate = [[NSDate date]dateByAddingTimeInterval: ([POTimer sharedInstance].minutes * 60) + [POTimer sharedInstance].seconds];
	localNotification.fireDate = fireDate;
	
	localNotification.timeZone = [NSTimeZone defaultTimeZone];
	localNotification.soundName = @"bell_tree.mp3";
	localNotification.alertBody = @"Time up";
	localNotification.applicationIconBadgeNumber = 1;
	
	
	[[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

- (void)setupAlert {
	//Local Alert for end of round
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Round Finished" message:@"Continue To Next Round?" preferredStyle:UIAlertControllerStyleAlert];
	
	//Left Button
	[alertController addAction:[UIAlertAction actionWithTitle:@"I'm sick of this" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
		self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];

	}]];
	
	//Right Button
	[alertController addAction:[UIAlertAction actionWithTitle:@"Next Round" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		[self newRound];
	}]];

	//add the alert 
	[self presentViewController:alertController animated:YES completion:nil];
}



- (IBAction)timerButtonPressed:(id)sender {
    self.timerButton.enabled = NO;
	[self.timerButton setHidden:YES];
    [[POTimer sharedInstance] startTimer];
    self.pauseButton.enabled = YES;
	[self.pauseButton setHidden:NO];
	[self setUpNotification];
}

- (IBAction)pauseButtonPressed:(UIButton *)sender {
	
	[POTimer sharedInstance].isOn = NO;
	self.pauseButton.enabled = NO;
	[self.pauseButton setHidden: YES];
	self.timerButton.enabled = YES;
	[self.timerButton setHidden:NO];
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}


-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:currentRoundNotifciation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupAlert) name:TimerCompleteNotification object:nil];
}

-(void)updateTimerLabel {
    self.timerLabel.text = [NSString stringWithFormat: @"%ld:%02ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

-(void)newRound{
    [self updateTimerLabel];
    self.timerButton.enabled = YES;
	  self.pauseButton.enabled = NO;
	[self.timerButton setHidden:NO];
	[self.pauseButton setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
