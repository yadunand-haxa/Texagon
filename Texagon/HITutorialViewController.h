//
//  HITutorialViewController.h
//  Texagon
//
//  Created by Ravern Koh on 1/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HIViewController.h"

CGRect beginRects[9];
CGRect endRects[9];

typedef enum {
    TutorialStageRedTile = 0,
    TutorialStageGreyTile = 1,
    TutorialStageBlueTile = 2,
    TutorialStageContinue = 3
} TutorialStage;

@interface HITutorialViewController : HIViewController

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UILabel *tutorialLabel;
@property (strong, nonatomic) NSURL *redURL;
@property (strong, nonatomic) NSURL *blueURL;
@property (strong, nonatomic) NSURL *grayURL;
@property (strong, nonatomic) AVAudioPlayer *redPlayer;
@property (strong, nonatomic) AVAudioPlayer *bluePlayer;
@property (strong, nonatomic) AVAudioPlayer *grayPlayer;
@property (assign, nonatomic) TutorialStage stage;
@property (assign, nonatomic) BOOL started;
@property (assign, nonatomic) CGFloat moves;
@property (strong, nonatomic) NSMutableArray *tiles;
@property (assign, nonatomic) NSInteger size;

@end
