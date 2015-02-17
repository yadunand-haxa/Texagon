//
//  HIMenuViewController.m
//  Texagon
//
//  Created by Ravern Koh on 4/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIMenuViewController.h"
#import "HIZenGameViewController.h"
#import "HIMultiplayerGameViewController.h"
#import "HIFlatPushDownwardSegue.h"
#import "HISettings.h"
#import "HIConstants.h"

@interface HIMenuViewController ()

@end

@implementation HIMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Not First"]) {
        self.fastestTimeLabel.text = @"Click Start...";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Not First"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        self.fastestTimeLabel.text = @"Texagon";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startButtonPressed:(UIButton *)sender
{
    if ([HISettings standardSettings].multiplayer) {
        self.manager = [[MCManager alloc] init];
        [self.manager setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
        [self.manager advertiseSelf:YES];
        [self.manager setupMCBrowser];
        self.manager.browser.delegate = self;
        [self presentViewController:self.manager.browser animated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:@"singleplayer" sender:self];
    }
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"multiplayer" sender:self];
    }];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
    self.manager = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"multiplayer"]) {
        HIMultiplayerGameViewController *vc = segue.destinationViewController;
        vc.manager = self.manager;
    }
}
- (IBAction)RateUs:(id)sender {{NSString *iTunesLink = @"https://itunes.apple.com/sg/app/id955319057";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    
}

@end
