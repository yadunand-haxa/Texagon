//
//  HIFadeOutSegue.m
//  Texagon
//
//  Created by Ravern Koh on 4/8/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIFadeOutSegue.h"
#import "HIConstants.h"

@implementation HIFadeOutSegue

- (void)perform
{
    UIViewController *source = [self sourceViewController];
    UIViewController *dest = [self destinationViewController];
    
    source.view.userInteractionEnabled = NO;
    dest.view.userInteractionEnabled = NO;
    dest.view.alpha = 0.0f;
    [source.view.superview addSubview:dest.view];
    [UIView animateWithDuration:HIFadeOutSegueAnimationSpeed animations:^{
        dest.view.alpha = 1.0f;
        source.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
         dest.view.removeFromSuperview;
        [source presentViewController:dest animated:NO completion:NULL];
        source.view.userInteractionEnabled = YES;
        dest.view.userInteractionEnabled = YES;
    }];
}

@end
