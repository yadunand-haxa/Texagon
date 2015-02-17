//
//  HIStartViewController.m
//  Texagon
//
//  Created by Ravern Koh on 4/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIStartViewController.h"
#import "HISettings.h"
#import <AVFoundation/AVFoundation.h>
#import "HIConstants.h"
#import "HIAppDelegate.h"


@interface HIStartViewController ()

@end

@implementation HIStartViewController

- (void)viewDidAppear:(BOOL)animated
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Not First"]) {
        [HISettings standardSettings].sound = YES;
        [HISettings standardSettings].music = YES;
    }
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"]];
    ((HIAppDelegate *)[UIApplication sharedApplication].delegate).player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    ((HIAppDelegate *)[UIApplication sharedApplication].delegate).player.numberOfLoops = -1;
    ((HIAppDelegate *)[UIApplication sharedApplication].delegate).player.volume = 0.5f;
    if ([HISettings standardSettings].music) [((HIAppDelegate *)[UIApplication sharedApplication].delegate).player play];
    else {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"red_tile_sound" ofType:@"m4a"]];
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [player play];
        [player stop];
    }
    [super viewDidAppear:animated];
    sleep(1.5);
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Not First"]) {
        [HISettings standardSettings].sound = YES;
        [HISettings standardSettings].music = YES;
        [self performSegueWithIdentifier:@"first" sender:self];
    } else {
        [self performSegueWithIdentifier:@"notfirst" sender:self];
    }

    
}

@end
