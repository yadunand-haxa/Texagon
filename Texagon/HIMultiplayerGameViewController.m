//
//  HIMultiplayerGameViewController.m
//  Texagon
//
//  Created by Ravern Koh on 11/9/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HIMultiplayerGameViewController.h"
#import "HIClassicWinViewController.h"
#import "HIFlatPushDownwardSegue.h"
#import "HITileView.h"
#import "HIAchievements.h"
#import "HIConstants.h"
#import "HISettings.h"

@interface HIMultiplayerGameViewController ()

@end

@implementation HIMultiplayerGameViewController

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
    self.moves = 30;
    self.time = 0;
    
    self.redURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"red_tile_sound" ofType:@"m4a"]];
    self.blueURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blue_tile_sound" ofType:@"m4a"]];
    self.grayURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gray_tile_sound" ofType:@"m4a"]];
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedDataAsNotification:) name:@"MCDidReceiveDataNotification" object:nil];
    
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
    self.moves--;
    if (self.moves <= 0) {
        [self win];
    }
    [self animateViewOut:((HITileView *)gr.view)];
    int random = arc4random_uniform(3);
    while (random == ((HITileView *)gr.view).type) {
        random = arc4random_uniform(3);
    }
    
    NSString *string = [NSString stringWithFormat:@"%d", (int)(random * 10 + ((HITileView *)gr.view).position)];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [self.manager.session sendData:data toPeers:self.manager.session.connectedPeers withMode:MCSessionSendDataReliable error:nil];
    
    SEL selector = @selector(changeViewType:toType:);
    if([self respondsToSelector:selector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        HITileView *arg1 = ((HITileView *)gr.view);
        NSNumber *arg2 = [NSNumber numberWithInt:random];
        [inv setArgument:&(arg1) atIndex:2];
        [inv setArgument:&(arg2) atIndex:3];
        [self performSelector:@selector(invoke:) withObject:inv afterDelay:HITileViewAnimationTime];
    }
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
    self.moves--;
    if (self.moves <= 0) {
        [self win];
    }
    [self animateViewOut:((HITileView *)gr.view)];
    int random = arc4random_uniform(3);
    while (random == ((HITileView *)gr.view).type) {
        random = arc4random_uniform(3);
    }
    
    NSString *string = [NSString stringWithFormat:@"%d", (int)(random * 10 + ((HITileView *)gr.view).position)];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [self.manager.session sendData:data toPeers:self.manager.session.connectedPeers withMode:MCSessionSendDataReliable error:nil];
    
    SEL selector = @selector(changeViewType:toType:);
    if([self respondsToSelector:selector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        HITileView *arg1 = ((HITileView *)gr.view);
        NSNumber *arg2 = [NSNumber numberWithInt:random];
        [inv setArgument:&(arg1) atIndex:2];
        [inv setArgument:&(arg2) atIndex:3];
        [self performSelector:@selector(invoke:) withObject:inv afterDelay:HITileViewAnimationTime];
    }
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
    self.moves--;
    if (self.moves <= 0) {
        [self win];
    }
    [self animateViewOut:((HITileView *)gr.view)];
    int random = arc4random_uniform(3);
    while (random == ((HITileView *)gr.view).type) {
        random = arc4random_uniform(3);
    }
    
    NSString *string = [NSString stringWithFormat:@"%d", (int)(random * 10 + ((HITileView *)gr.view).position)];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [self.manager.session sendData:data toPeers:self.manager.session.connectedPeers withMode:MCSessionSendDataReliable error:nil];
    
    SEL selector = @selector(changeViewType:toType:);
    if([self respondsToSelector:selector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        HITileView *arg1 = ((HITileView *)gr.view);
        NSNumber *arg2 = [NSNumber numberWithInt:random];
        [inv setArgument:&(arg1) atIndex:2];
        [inv setArgument:&(arg2) atIndex:3];
        [self performSelector:@selector(invoke:) withObject:inv afterDelay:HITileViewAnimationTime];
    }
}

- (void)receivedDataAsNotification:(NSNotification *)noti
{
    int data = [[[NSString alloc] initWithData:noti.userInfo[@"data"] encoding:NSUTF8StringEncoding] intValue];
    NSLog(@"%d", [NSThread currentThread] == [NSThread mainThread]);
    [self performSelectorOnMainThread:@selector(changeView:) withObject:[NSNumber numberWithInt:data] waitUntilDone:NO];
}

- (void)changeView:(NSNumber *)objcdata
{
    int data = [objcdata intValue];
    int type = data / 10;
    int pos = data % 10;
    
    [self animateViewOut:((HITileView *)self.tiles[pos])];
    SEL selector = @selector(changeViewType:toType:);
    if ([self respondsToSelector:selector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        HITileView *arg1 = ((HITileView *)self.tiles[pos]);
        NSNumber *arg2 = [NSNumber numberWithInt:type];
        [inv setArgument:&(arg1) atIndex:2];
        [inv setArgument:&(arg2) atIndex:3];
        double delayInSeconds = HITileViewAnimationTime;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self performSelectorOnMainThread:@selector(invoke:) withObject:inv waitUntilDone:NO];
        });
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
    [self performSelector:@selector(performWinSegue) withObject:nil afterDelay:1.0f];
}

- (void)performWinSegue
{
    [self performSegueWithIdentifier:@"win" sender:self];
}

- (void)animateViewOut:(HITileView *)view
{
    [view animateTo:beginRects[view.position]];
    double delayInSeconds = HITileViewAnimationTime;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelectorOnMainThread:@selector(animateViewIn:) withObject:view waitUntilDone:NO];
    });
}

- (void)changeViewType:(HITileView *)view toType:(NSNumber *)type
{
    view.type = [type intValue];
}

- (void)animateViewIn:(HITileView *)view
{
    [view animateTo:endRects[view.position]];
}

- (void)timer
{
    self.time += CFAbsoluteTimeGetCurrent() - previousTime;
    previousTime = CFAbsoluteTimeGetCurrent();
}

- (void)setMoves:(CGFloat)moves
{
    _moves = moves;
    if (_moves < 0) {
        _moves = 0;
    }
    self.movesLabel.text = [NSString stringWithFormat:@"Moves Left: %.0f", moves];
}

- (void)setTime:(CGFloat)time
{
    _time = time;
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %.2f", time];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"win"]) {
        ((HIClassicWinViewController *)segue.destinationViewController).winData = @{
                                                                             @"Time" : [NSNumber numberWithFloat:self.time]
                                                                             };
    }
}

@end
