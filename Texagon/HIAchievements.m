//
//  HIAchievements.m
//  Texagon
//
//  Created by Ravern Koh on 10/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIAchievements.h"
#import "HIAchievementView.h"
#import "HIConstants.h"

@implementation HIAchievements

+ (HIAchievements *)achievements
{
    return [[HIAchievements alloc] init];
}

- (BOOL)notFirstGame
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"Not First Game"];
}

- (void)setNotFirstGame:(BOOL)notFirstGame
{
    [[NSUserDefaults standardUserDefaults] setBool:notFirstGame forKey:@"Not First Game"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (notFirstGame) {
        HIAchievementView *view = [[HIAchievementView alloc] initWithImage:[UIImage imageNamed:@"achievement_first_game.png"]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        [view show];
    }
}

- (BOOL)allRed
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"All Red"];
}

- (void)setAllRed:(BOOL)allRed
{
    [[NSUserDefaults standardUserDefaults] setBool:allRed forKey:@"All Red"];    [[NSUserDefaults standardUserDefaults] synchronize];
    if (allRed) {
        HIAchievementView *view = [[HIAchievementView alloc] initWithImage:[UIImage imageNamed:@"achievement_all_red.png"]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        [view show];
    }
}

- (BOOL)allBlue
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"All Blue"];
}

- (void)setAllBlue:(BOOL)allBlue
{
    [[NSUserDefaults standardUserDefaults] setBool:allBlue forKey:@"All Blue"];    [[NSUserDefaults standardUserDefaults] synchronize];
    if (allBlue) {
        HIAchievementView *view = [[HIAchievementView alloc] initWithImage:[UIImage imageNamed:@"achievement_all_blue.png"]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        [view show];
    }
}

- (BOOL)allGray
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"All Gray"];
}

- (void)setAllGray:(BOOL)allGray
{
    [[NSUserDefaults standardUserDefaults] setBool:allGray forKey:@"All Gray"];    [[NSUserDefaults standardUserDefaults] synchronize];
    if (allGray) {
        HIAchievementView *view = [[HIAchievementView alloc] initWithImage:[UIImage imageNamed:@"achievement_all_gray.png"]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        [view show];
    }
}

- (BOOL)subTen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"Sub Ten"];
}

- (void)setSubTen:(BOOL)subTen
{
    [[NSUserDefaults standardUserDefaults] setBool:subTen forKey:@"Sub Ten"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (subTen) {
        HIAchievementView *view = [[HIAchievementView alloc] initWithImage:[UIImage imageNamed:@"achievement_sub_10.png"]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
        [view show];
    }
}

- (NSArray *)receivedAchievements
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if (self.allRed) {
        [array addObject:@"All Red"];
    }
    if (self.allGray) {
        [array addObject:@"All Gray"];
    }
    if (self.allBlue) {
        [array addObject:@"All Blue"];
    }
    if (self.subTen) {
        [array addObject:@"Sub Ten"];
    }
    if (self.notFirstGame) {
        [array addObject:@"First Game"];
    }
    
    return array;
}

- (NSArray *)notReceivedAchievements
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if (!self.allRed) {
        [array addObject:@"All Red"];
    }
    if (!self.allGray) {
        [array addObject:@"All Gray"];
    }
    if (!self.allBlue) {
        [array addObject:@"All Blue"];
    }
    if (!self.subTen) {
        [array addObject:@"Sub Ten"];
    }
    if (!self.notFirstGame) {
        [array addObject:@"First Game"];
    }
    
    return array;
}

@end
