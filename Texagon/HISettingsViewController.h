//
//  HISettingsViewController.h
//  Texagon
//
//  Created by Ravern Koh on 19/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIViewController.h"

@interface HISettingsViewController : HIViewController

@property (strong, nonatomic) IBOutlet UIButton *multiplayerButton;
@property (strong, nonatomic) IBOutlet UIButton *soundButton;
@property (strong, nonatomic) IBOutlet UIButton *musicButton;

- (IBAction)multiplayerButtonPressed:(UIButton *)sender;
- (IBAction)soundButtonPressed:(UIButton *)sender;
- (IBAction)musicButtonPressed:(UIButton *)sender;

@end
