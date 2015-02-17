//
//  HIZenWinViewController.h
//  Texagon
//
//  Created by Ravern Koh on 12/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIViewController.h"

@interface HIZenWinViewController : HIViewController

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *fastestTimeLabel;
@property (strong, nonatomic) NSDictionary *winData;

- (IBAction)shareButtonPressed:(UIButton *)sender;

@end
