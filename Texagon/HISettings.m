//
//  HISettings.m
//  SST Tiles
//
//  Created by Ravern Koh on 3/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HISettings.h"
#import "HIConstants.h"

@implementation HISettings

+ (HISettings *)standardSettings
{
    return [[[self class] alloc] init];
}

- (CGFloat)classicHighscore
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"Classic Highscore"];
}

- (void)setClassicHighscore:(CGFloat)classicHighscore
{
    [[NSUserDefaults standardUserDefaults] setFloat:classicHighscore forKey:@"Classic Highscore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)zenHighscore
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"Zen Highscore"];
}

- (void)setZenHighscore:(NSInteger)zenHighscore
{
    [[NSUserDefaults standardUserDefaults] setInteger:zenHighscore forKey:@"Zen Highscore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)timeAttackHighscore
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"TA Highscore"];
}

- (void)setTimeAttackHighscore:(NSInteger)timeAttackHighscore
{
    [[NSUserDefaults standardUserDefaults] setInteger:timeAttackHighscore forKey:@"TA Highscore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)multiplayer
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"Multiplayer"];
}

- (void)setMultiplayer:(BOOL)multiplayer
{
    [[NSUserDefaults standardUserDefaults] setFloat:multiplayer forKey:@"Multiplayer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)sound
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"Sound"];
}

- (void)setSound:(BOOL)sound
{
    [[NSUserDefaults standardUserDefaults] setFloat:sound forKey:@"Sound"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)music
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"Music"];
}

- (void)setMusic:(BOOL)music
{
    [[NSUserDefaults standardUserDefaults] setFloat:music forKey:@"Music"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
