//
//  HIZenWinViewController.m
//  Texagon
//
//  Created by Ravern Koh on 12/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIZenWinViewController.h"
#import "HISettings.h"
#import "HIAchievements.h"
#import <Social/Social.h>
#import "HIConstants.h"

@interface HIZenWinViewController ()

@end

@implementation HIZenWinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![HIAchievements achievements].notFirstGame) {
        [HIAchievements achievements].notFirstGame = YES;
    }
    
    int score = (int)[((NSNumber *)self.winData[@"Moves"]) integerValue];
    int highscore = (int)[HISettings standardSettings].zenHighscore;
    if (score > highscore) {
        [HISettings standardSettings].zenHighscore = score;
        highscore = score;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"Moves: %ld", (long)score];
    self.fastestTimeLabel.text = [NSString stringWithFormat:@"Most Moves: %ld", (long)highscore];
}

- (IBAction)shareButtonPressed:(UIButton *)sender
{
    int score = [((NSNumber *)self.winData[@"Moves"]) intValue];
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [vc setInitialText:[NSString stringWithFormat:@"I got %d moves in Texagon, Zen mode! Come try out Texagon today @ https://itunes.apple.com/SG/app/id955319057?mt=8", score]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
