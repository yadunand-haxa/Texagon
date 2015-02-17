//
//  HIGameViewController.m
//  SST Tiles
//
//  Created by Ravern Koh on 31/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HITimeAttackGameViewController.h"
#import "HIClassicWinViewController.h"
#import "HITimeAttackWinViewController.h"
#import "HIFlatPushDownwardSegue.h"
#import "HITileView.h"
#import "HIAchievements.h"
#import "HIConstants.h"
#import "HISettings.h"

@interface HITimeAttackGameViewController ()

@end

@implementation HITimeAttackGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    beginRects[0] = CGRectMake(-110, -100, 100, 100);
    endRects[0] = CGRectMake(10, 170, 100, 100);
    
    beginRects[1] = CGRectMake(110, -100, 100, 100);
    endRects[1] = CGRectMake(110, 120, 100, 100);
    
    beginRects[2] = CGRectMake(410, -100, 100, 100);
    endRects[2] = CGRectMake(210, 170, 100, 100);
    
    beginRects[3] = CGRectMake(-110, 588, 100, 100);
    endRects[3] = CGRectMake(10, 270, 100, 100);
    
    beginRects[4] = CGRectMake(-110, 220, 100, 100);
    endRects[4] = CGRectMake(110, 220, 100, 100);
    
    beginRects[5] = CGRectMake(410, 588, 100, 100);
    endRects[5] = CGRectMake(210, 270, 100, 100);
    
    beginRects[6] = CGRectMake(110, 588, 100, 100);
    endRects[6] = CGRectMake(110, 320, 100, 100);
    
    [self performSelector:@selector(setup) withObject:nil afterDelay:0.5f];
    self.tiles = [NSMutableArray new];
    self.moves = 0;
    self.time = 3;
    
    self.redURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"red_tile_sound" ofType:@"m4a"]];
    self.blueURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blue_tile_sound" ofType:@"m4a"]];
    self.grayURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gray_tile_sound" ofType:@"m4a"]];
}

- (void)setup
{
    for (int i = 0; i < HIBoardsize; i++) {
        HITileView *view = [[HITileView alloc] init];
        [self.view addSubview:view];
        [self.tiles addObject:view];
        view.target = self;
        view.position = i;
        view.type = arc4random_uniform(3);
        view.frame = beginRects[i];
        view.userInteractionEnabled = YES;
        [view animateTo:endRects[i]];
    }
}

- (void)tileTapped:(UITapGestureRecognizer *)gr
{
    if ([HISettings standardSettings].sound) {
        self.redPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.redURL error:nil];
        self.redPlayer.volume = 5.0f;
        [self.redPlayer play];
    }
    if (!self.started) {
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.updateTimer forMode:NSDefaultRunLoopMode];
        previousTime = CFAbsoluteTimeGetCurrent();
        self.started = YES;
    }
    self.moves++;
    self.time += 0.2f;
    [self tappedView:((HITileView *)gr.view)];
}

- (void)tileSwiped:(UISwipeGestureRecognizer *)gr
{
    if ([HISettings standardSettings].sound) {
        self.bluePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.blueURL error:nil];
        self.bluePlayer.volume = 3.0f;
        [self.bluePlayer play];
    }
    if (!self.started) {
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.updateTimer forMode:NSDefaultRunLoopMode];
        previousTime = CFAbsoluteTimeGetCurrent();
        self.started = YES;
    }
    self.moves++;
    self.time += 0.2f;
    [self tappedView:((HITileView *)gr.view)];
}

- (void)tileLongPressed:(UITapGestureRecognizer *)gr
{
    if ([HISettings standardSettings].sound) {
        self.grayPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.grayURL error:nil];
        self.grayPlayer.volume = 5.0f;
        [self.grayPlayer play];
    }
    if (!self.started) {
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.updateTimer forMode:NSDefaultRunLoopMode];
        previousTime = CFAbsoluteTimeGetCurrent();
        self.started = YES;
    }
    self.moves++;
    self.time += 0.2f;
    [self tappedView:((HITileView *)gr.view)];
}

- (void)tappedView:(HITileView *)view
{
    [self animateViewOut:view];
    int random = arc4random_uniform(3);
    while (random == view.type) {
        random = arc4random_uniform(3);
    }
    SEL selector = @selector(changeViewType:toType:);
    
    if([self respondsToSelector:selector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        HITileView *arg1 = view;
        NSNumber *arg2 = [NSNumber numberWithInt:random];
        [inv setArgument:&(arg1) atIndex:2];
        [inv setArgument:&(arg2) atIndex:3];
        [self performSelector:@selector(invoke:) withObject:inv afterDelay:HITileViewAnimationTime];
    }
}

- (void)invoke:(NSInvocation *)inv
{
    [inv invoke];
}

-(void)win
{
    self.view.userInteractionEnabled = NO;
    [self.updateTimer invalidate];
    [self performSelector:@selector(performWinSegue) withObject:nil afterDelay:HIWinSegueDelay];
    [self performSelector:@selector(addBlankView) withObject:nil afterDelay:HIBlankViewAddTime];
    for (HITileView *view in self.tiles) {
        [self animateViewOut:view];
        [self performSelector:@selector(removeView:) withObject:view afterDelay:HIBlankViewAddTime];
    }
}

-(void)addBlankView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.4352f green:0.4509f blue:0.4627f alpha:1.0];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:self.movesLabel];
    [self.view bringSubviewToFront:self.timeLabel];
}

- (void)removeView:(UIView *)view
{
    [view removeFromSuperview];
}

- (void)performWinSegue
{
    [self performSegueWithIdentifier:@"win" sender:self];
}

- (void)animateViewOut:(HITileView *)view
{
    [view animateTo:beginRects[view.position]];
    [self performSelector:@selector(animateViewIn:) withObject:view afterDelay:HITileViewAnimationTime];
}

- (void)changeViewType:(HITileView *)view toType:(NSNumber *)type
{
    view.type = [type intValue];
    if (![HIAchievements achievements].allRed) {
        BOOL same = YES;
        int previousType = 1;
        for (HITileView *view in self.tiles) {
            if (view.type != previousType) {
                same = NO;
                break;
            }
        }
        if (same) {
            [HIAchievements achievements].allRed = YES;
        }
    }
    if (![HIAchievements achievements].allBlue) {
        BOOL same = YES;
        int previousType = 2;
        for (HITileView *view in self.tiles) {
            if (view.type != previousType) {
                same = NO;
                break;
            }
        }
        if (same) {
            [HIAchievements achievements].allBlue = YES;
        }
    }
    if (![HIAchievements achievements].allGray) {
        BOOL same = YES;
        int previousType = 0;
        for (HITileView *view in self.tiles) {
            if (view.type != previousType) {
                same = NO;
                break;
            }
        }
        if (same) {
            [HIAchievements achievements].allGray = YES;
        }
    }
}

- (void)animateViewIn:(HITileView *)view
{
    [view animateTo:endRects[view.position]];
}

- (void)timer
{
    self.time -= CFAbsoluteTimeGetCurrent() - previousTime;
    if (self.time <= 0) {
        self.time = 0;
        [self win];
    }
    previousTime = CFAbsoluteTimeGetCurrent();
}

- (void)setMoves:(CGFloat)moves
{
    _moves = moves;
    if (_moves < 0) {
        _moves = 0;
    }
    self.movesLabel.text = [NSString stringWithFormat:@"Moves: %.0f", moves];
}

- (void)setTime:(CGFloat)time
{
    _time = time;
    self.timeLabel.text = [NSString stringWithFormat:@"Time Left: %.2f", time];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"win"]) {
        ((HITimeAttackWinViewController *)segue.destinationViewController).winData = @{
                                                                             @"Moves" : [NSNumber numberWithInt:self.moves]
                                                                             };
    }
}

@end
