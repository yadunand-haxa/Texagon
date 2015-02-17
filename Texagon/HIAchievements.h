//
//  HIAchievements.h
//  Texagon
//
//  Created by Ravern Koh on 10/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HIAchievements : NSObject

@property (assign, nonatomic) BOOL notFirstGame;
@property (assign, nonatomic) BOOL subTen;
@property (assign, nonatomic) BOOL allGray;
@property (assign, nonatomic) BOOL allRed;
@property (assign, nonatomic) BOOL allBlue;

+ (HIAchievements *)achievements;
- (NSArray *)receivedAchievements;
- (NSArray *)notReceivedAchievements;

@end
