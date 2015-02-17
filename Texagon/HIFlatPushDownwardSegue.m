//
//  RWFlatPushSegue.m
//  Side Effects
//
//  Created by Ravern Koh on 31/5/14.
//  Copyright (c) 2014 R3Workx.org. All rights reserved.
//

#import "HIFlatPushDownwardSegue.h"
#import "HIConstants.h"

@implementation HIFlatPushDownwardSegue

- (void)perform
{
    UIViewController *source = [self sourceViewController];
    UIViewController *dest = [self destinationViewController];
    
    source.view.userInteractionEnabled = NO;
    dest.view.userInteractionEnabled = NO;
    [source.view addSubview:dest.view];
    dest.view.frame = CGRectMake(dest.view.frame.origin.x, dest.view.frame.origin.y + dest.view.frame.size.height, dest.view.frame.size.width, dest.view.frame.size.height);
    [UIView animateWithDuration:HIFlatPushSegueAnimationSpeed animations:^{
        source.view.frame = CGRectMake(source.view.frame.origin.x, -source.view.frame.size.height, source.view.frame.size.width, source.view.frame.size.height);
    } completion:^(BOOL finished) {
         dest.view.removeFromSuperview;
        [source presentViewController:dest animated:NO completion:NULL];
        source.view.userInteractionEnabled = YES;
        dest.view.userInteractionEnabled = YES;
    }];
}

@end
