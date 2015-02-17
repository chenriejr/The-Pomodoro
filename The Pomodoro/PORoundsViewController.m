//
//  PORoundsViewController.m
//  The Pomodoro
//
//  Created by Jake Herrmann on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "PORoundsViewController.h"
#import "POTimer.h"

@interface PORoundsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PORoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
 
    [self.view addSubview:self.tableView];
    
}

-(NSArray *)roundTimes{
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
    cell.textLabel.text = [NSString stringWithFormat: @"Round %ld - %@ minutes", (long)indexPath.row + 1, [self roundTimes][indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentRound = indexPath.row;
    [self roundSelected];
    
}

-(void)roundSelected{
    [POTimer sharedInstance].minutes = [[self roundTimes][self.currentRound]integerValue];
    [POTimer sharedInstance].seconds = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:currentRoundNotifciation object:nil];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self roundTimes].count;
    
}

-(void)registerForNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundComplete) name:TimerCompleteNotification object:nil];
    
}

-(void)unregisterForNotifications{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)roundComplete{
    if (self.currentRound < [self roundTimes].count-1) {
        self.currentRound++;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRound inSection:0]animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self roundSelected];
    }
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
