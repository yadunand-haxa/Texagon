//
//  HIAchievementsTableViewController.m
//  Texagon
//
//  Created by Ravern Koh on 13/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIAchievementsTableViewController.h"
#import "HIAchievementViewController.h"
#import "HIAchievements.h"
#import "HIConstants.h"

@interface HIAchievementsTableViewController ()

@end

@implementation HIAchievementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([HIAchievements achievements].receivedAchievements.count) {
            return [HIAchievements achievements].receivedAchievements.count;
        } else {
            return 1;
        }
    }
    if ([HIAchievements achievements].notReceivedAchievements.count) {
        return [HIAchievements achievements].notReceivedAchievements.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (indexPath.section == 0) {
        if ([HIAchievements achievements].receivedAchievements.count) {
            cell.textLabel.text = [HIAchievements achievements].receivedAchievements[indexPath.row];
        } else {
            cell.textLabel.text = @"Nothing";
        }
    } else {
        if ([HIAchievements achievements].notReceivedAchievements.count) {
            cell.textLabel.text = [HIAchievements achievements].notReceivedAchievements[indexPath.row];
        } else {
            cell.textLabel.text = @"Nothing";
        }
    }
    if (indexPath.row != 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 0, tableView.frame.size.width - 32, 1)];
        view.backgroundColor = [UIColor colorWithRed:0.4352f green:0.4509f blue:0.4627f alpha:1.0];
        [cell addSubview:view];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"TimeBurner" size:19];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.textLabel.layer.borderWidth = 1.0f;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle;
    if (section == 0) {
        sectionTitle = @"You have achieved...";
    } else {
        sectionTitle = @"Remaining challenges...";
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 17, tableView.bounds.size.width - 40, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"TimeBurner" size:25];
    label.text = sectionTitle;
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 54)];
    [view addSubview:label];
    
    return view;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"]) {
        ((HIAchievementViewController *)segue.destinationViewController).achievementName = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]].textLabel.text;
    }
}

@end
