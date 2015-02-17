//
//  HISettings.h
//  SST Tiles
//
//  Created by Ravern Koh on 3/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HISettings: NSObject

@property (assign, nonatomic) CGFloat classicHighscore;
@property (assign, nonatomic) NSInteger zenHighscore;
@property (assign, nonatomic) NSInteger timeAttackHighscore;
@property (assign, nonatomic) BOOL multiplayer;
@property (assign, nonatomic) BOOL sound;
@property (assign, nonatomic) BOOL music;

+ (HISettings *)standardSettings;

@end
