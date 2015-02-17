//
//  HIMenuViewController.h
//  Texagon
//
//  Created by Ravern Koh on 4/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCManager.h"
#import "HIViewController.h"

@interface HIMenuViewController : HIViewController <MCBrowserViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *fastestTimeLabel;
@property (strong, nonatomic) MCManager *manager;

- (IBAction)startButtonPressed:(UIButton *)sender;

@end
