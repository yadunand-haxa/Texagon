//
//  HIAchievementViewController.h
//  Texagon
//
//  Created by Ravern Koh on 13/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HIViewController.h"

@interface HIAchievementViewController : HIViewController

@property (strong, nonatomic) NSString *achievementName;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
