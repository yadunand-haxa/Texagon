//
//  HIAchievementViewController.m
//  Texagon
//
//  Created by Ravern Koh on 13/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIAchievementViewController.h"
#import "HIConstants.h"

@interface HIAchievementViewController ()

@end

@implementation HIAchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.achievementName isEqualToString:@"All Red"]) {
        self.descriptionLabel.text = @"Make all 9 tiles red on the board.";
    } else if ([self.achievementName isEqualToString:@"All Blue"]) {
        self.descriptionLabel.text = @"Make all 9 tiles blue on the board.";
    } else if ([self.achievementName isEqualToString:@"All Gray"]) {
        self.descriptionLabel.text = @"Make all 9 tiles gray on the board.";
    } else if ([self.achievementName isEqualToString:@"Sub Ten"]) {
        self.descriptionLabel.text = @"Achieve a score lesser than 10.00s in Classic Mode.";
    } else if ([self.achievementName isEqualToString:@"First Game"]) {
        self.descriptionLabel.text = @"Play your first game.";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
