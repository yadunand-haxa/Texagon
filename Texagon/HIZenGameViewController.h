//
//  HIGameViewController.h
//  SST Tiles
//
//  Created by Ravern Koh on 31/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HIViewController.h"

CGRect beginRects[7];
CGRect endRects[7];

@interface HIZenGameViewController : HIViewController
{
    CFAbsoluteTime previousTime;
}

#define MAX_TIME_ALLOWED 3.0f

@property (strong, nonatomic) IBOutlet UILabel *movesLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSURL *redURL;
@property (strong, nonatomic) NSURL *blueURL;
@property (strong, nonatomic) NSURL *grayURL;
@property (strong, nonatomic) AVAudioPlayer *redPlayer;
@property (strong, nonatomic) AVAudioPlayer *grayPlayer;
@property (strong, nonatomic) AVAudioPlayer *bluePlayer;
@property (strong, nonatomic) NSTimer *updateTimer;
@property (assign, nonatomic) BOOL started;
@property (assign, nonatomic) CGFloat moves;
@property (assign, nonatomic) CGFloat time;
@property (strong, nonatomic) NSMutableArray *tiles;
@property (assign, nonatomic) NSInteger size;

@end
