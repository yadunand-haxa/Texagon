//
//  HIViewController.m
//  Texagon
//
//  Created by Ravern Koh on 23/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIViewController.h"
#import "HISettings.h"

@interface HIViewController ()

@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation HIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button_sound" ofType:@"m4a"]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    if ([HISettings standardSettings].sound) [self.player play];
}

@end
