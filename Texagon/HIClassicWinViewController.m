//
//  HIWinViewController.m
//  SST Tiles
//
//  Created by Ravern Koh on 2/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIClassicWinViewController.h"
#import "HISettings.h"
#import "HIAchievements.h"
#import "HIAchievementView.h"
#import <Social/Social.h>
#import "HIConstants.h"

@implementation HIClassicWinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat score = [((NSNumber *)self.winData[@"Time"]) floatValue];
    CGFloat highscore = [HISettings standardSettings].classicHighscore;
    if (highscore == 0.0f || score < highscore) {
        [HISettings standardSettings].classicHighscore = score;
        highscore = score;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %.2f", score];
    self.fastestTimeLabel.text = [NSString stringWithFormat:@"Fastest Time: %.2f", highscore];
    
    if (![HIAchievements achievements].notFirstGame) {
        [HIAchievements achievements].notFirstGame = YES;
    }
    if (![HIAchievements achievements].subTen && score < 10) {
        [HIAchievements achievements].subTen = YES;
    }
}

- (IBAction)shareButtonPressed:(UIButton *)sender
{
    CGFloat score = [((NSNumber *)self.winData[@"Time"]) floatValue];
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [vc setInitialText:[NSString stringWithFormat:@"I got a timing of %.2f in Texagon, Classic mode! Come try out Texagon today @ https://itunes.apple.com/SG/app/id955319057?mt=8", score]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
