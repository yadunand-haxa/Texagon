//
//  HIAchievementView.m
//  Texagon
//
//  Created by Ravern Koh on 9/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIAchievementView.h"
#import "HIConstants.h"

@implementation HIAchievementView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 300, 80);
    }
    return self;
}

- (void)show
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(showSelector:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)showSelector:(NSTimer *)sender
{
    if (currentAnimatingView == nil) {
        currentAnimatingView = self;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView animateWithDuration:0.5f animations:^{
            self.frame = CGRectMake(self.frame.origin.x - 300, self.frame.origin.y, 300, 80);
        } completion:^(BOOL finished) {
            if (finished) {
                [self performSelector:@selector(hide) withObject:nil afterDelay:1.5f];
            }
        }];
        [sender invalidate];
    }
}

- (void)hide
{
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = CGRectMake(self.frame.origin.x + 300, self.frame.origin.y, 300, 80);
    } completion:^(BOOL finished) {
        if (finished) {
            currentAnimatingView = nil;
        }
    }];
}

@end
