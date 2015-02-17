//
//  HISettingsViewController.m
//  Texagon
//
//  Created by Ravern Koh on 19/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HISettingsViewController.h"
#import "HISettings.h"
#import "HIConstants.h"
#import "HIAppDelegate.h"

@interface HISettingsViewController ()

@end

@implementation HISettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([HISettings standardSettings].multiplayer) {
        [self.multiplayerButton setTitle:@"Multiplayer: On" forState:UIControlStateNormal];
    } else {
        [self.multiplayerButton setTitle:@"Multiplayer: Off" forState:UIControlStateNormal];
    }
    if ([HISettings standardSettings].sound) {
        [self.soundButton setTitle:@"Sound: On" forState:UIControlStateNormal];
    } else {
        [self.soundButton setTitle:@"Sound: Off" forState:UIControlStateNormal];
    }
    if ([HISettings standardSettings].music) {
        [self.musicButton setTitle:@"Music: On" forState:UIControlStateNormal];
    } else {
        [self.musicButton setTitle:@"Music: Off" forState:UIControlStateNormal];
    }
}

- (IBAction)multiplayerButtonPressed:(UIButton *)sender
{
    if ([sender.titleLabel.text hasSuffix:@"On"]) {
        [sender setTitle:@"Multiplayer: Off" forState:UIControlStateNormal];
        [HISettings standardSettings].multiplayer = NO;
    } else if ([sender.titleLabel.text hasSuffix:@"Off"]) {
        [sender setTitle:@"Multiplayer: On" forState:UIControlStateNormal];
        [HISettings standardSettings].multiplayer = YES;
    }
}

- (IBAction)soundButtonPressed:(UIButton *)sender
{
    if ([sender.titleLabel.text hasSuffix:@"On"]) {
        [sender setTitle:@"Sound: Off" forState:UIControlStateNormal];
        [HISettings standardSettings].sound = NO;
    } else if ([sender.titleLabel.text hasSuffix:@"Off"]) {
        [sender setTitle:@"Sound: On" forState:UIControlStateNormal];
        [HISettings standardSettings].sound = YES;
    }
}

- (IBAction)musicButtonPressed:(UIButton *)sender
{
    if ([sender.titleLabel.text hasSuffix:@"On"]) {
        [sender setTitle:@"Music: Off" forState:UIControlStateNormal];
        [HISettings standardSettings].music = NO;
        [((HIAppDelegate *)[UIApplication sharedApplication].delegate).player stop];
    } else if ([sender.titleLabel.text hasSuffix:@"Off"]) {
        [sender setTitle:@"Music: On" forState:UIControlStateNormal];
        [HISettings standardSettings].music = YES;
        [((HIAppDelegate *)[UIApplication sharedApplication].delegate).player play];
    }
}

@end
