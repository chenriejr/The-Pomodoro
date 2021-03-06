//
//  POAppDelegate.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAppDelegate.h"
#import "POTimerViewController.h"
#import "PORoundsViewController.h"
#import "POAppearanceController.h"

@implementation POAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Setup the View controller to go into the Tab Controller
    POTimerViewController *timerViewController = [POTimerViewController new];
    PORoundsViewController *roundsViewController = [PORoundsViewController new];

   
//Setup the Tab Bar Controller
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[roundsViewController, timerViewController];
    
    //Rounds Tab
    roundsViewController.tabBarItem.image = [UIImage imageNamed:@"rounds"];
    roundsViewController.tabBarItem.title = @"Rounds";
    roundsViewController.tabBarController.title = @"Pomodoro Rounds";
    
    
    //Timer Tab
    timerViewController.tabBarItem.image = [UIImage imageNamed:@"time"];
    timerViewController.tabBarItem.title = @"Timer";
    
    //Create a Navigation Controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    [POAppearanceController setUpAppearance];
    
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
{
	[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
	

	
}
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//	[[[UIAlertView alloc]initWithTitle:@"Round Completed" message:@"" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil]show];
//	
//	 application.applicationIconBadgeNumber = 0;
//	
//}


	
	
	


@end
