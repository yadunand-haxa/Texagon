//
//  HIWinViewController.h
//  SST Tiles
//
//  Created by Ravern Koh on 2/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIViewController.h"

@interface HIClassicWinViewController : HIViewController

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *fastestTimeLabel;
@property (strong, nonatomic) NSDictionary *winData;

- (IBAction)shareButtonPressed:(UIButton *)sender;

@end
