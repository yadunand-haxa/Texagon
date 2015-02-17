//
//  HIGameViewController.m
//  SST Tiles
//
//  Created by Ravern Koh on 31/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HITutorialViewController.h"
#import "HIClassicWinViewController.h"
#import "HIFlatPushDownwardSegue.h"
#import "HITileView.h"
#import "HIConstants.h"
#import "HISettings.h"

@interface HITutorialViewController ()

@end

@implementation HITutorialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Not First"]) {
        self.closeButton.hidden = NO;
    }
    
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
        view.userInteractionEnabled = NO;
        if (view.type == 1) {
            view.userInteractionEnabled = YES;
        }
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
    if (self.stage == TutorialStageRedTile) {
        self.stage = TutorialStageGreyTile;
        self.tutorialLabel.text = @"Double tap grey tiles.";
    }
    self.moves--;
    if (self.moves <= 0) {
        [self win];
    }
    [self animateViewOut:((HITileView *)gr.view)];
    [self performSelector:@selector(changeViewType:) withObject:gr.view afterDelay:HITileViewAnimationTime];
}

- (void)tileSwiped:(UISwipeGestureRecognizer *)gr
{
    if ([HISettings standardSettings].sound) {
        self.bluePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.blueURL error:nil];
        self.bluePlayer.volume = 3.0f;
        [self.bluePlayer play];
    }
    if (self.stage == TutorialStageBlueTile) {
        self.stage = TutorialStageContinue;
        self.tutorialLabel.text = @"Do a few more moves.";
    }
    self.moves--;
    if (self.moves <= 0) {
        [self win];
    }
    [self animateViewOut:((HITileView *)gr.view)];
    [self performSelector:@selector(changeViewType:) withObject:gr.view afterDelay:HITileViewAnimationTime];
}

- (void)tileLongPressed:(UITapGestureRecognizer *)gr
{
    if ([HISettings standardSettings].sound) {
        self.grayPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.grayURL error:nil];
        self.grayPlayer.volume = 5.0f;
        [self.grayPlayer play];
    }
    if (self.stage == TutorialStageGreyTile) {
        self.stage = TutorialStageBlueTile;
        self.tutorialLabel.text = @"Swipe blue tiles.";
    }
    self.moves--;
    if (self.moves <= 0) {
        [self win];
    }
    [self animateViewOut:((HITileView *)gr.view)];
    [self performSelector:@selector(changeViewType:) withObject:gr.view afterDelay:HITileViewAnimationTime];
}

-(void)win
{
    for (HITileView *view in self.tiles) {
        [self animateViewOut:view];
        [self performSelector:@selector(removeView:) withObject:view afterDelay:HIBlankViewAddTime];
    }
    [self performSelector:@selector(addBlankView) withObject:nil afterDelay:HIBlankViewAddTime];
    self.tutorialLabel.text = @"You have completed the tutorial.";
    self.closeButton.hidden = NO;
    self.closeButton.userInteractionEnabled = YES;
}

- (void)removeView:(UIView *)view
{
    [view removeFromSuperview];
}

-(void)addBlankView
{
    self.closeButton.hidden = NO;
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

- (void)changeViewType:(HITileView *)view
{
    int random = arc4random_uniform(3);
    while (random == view.type) {
        random = arc4random_uniform(3);
    }
    view.type = random;
    for (int i = 0; i < HIBoardsize; i++) {
        HITileView *view = self.tiles[i];
        if (self.stage == TutorialStageRedTile) {
            if (view.type == 0) {
                view.userInteractionEnabled = YES;
            }
            if (view.type == 1) {
                view.userInteractionEnabled = NO;
            }
            if (view.type == 2) {
                view.userInteractionEnabled = NO;
            }
        }
        if (self.stage == TutorialStageGreyTile) {
            if (view.type == 0) {
                view.userInteractionEnabled = YES;
            }
            if (view.type == 1) {
                view.userInteractionEnabled = YES;
            }
            if (view.type == 2) {
                view.userInteractionEnabled = NO;
            }        }
        if (self.stage == TutorialStageBlueTile) {
            if (view.type == 0) {
                view.userInteractionEnabled = YES;
            }
            if (view.type == 1) {
                view.userInteractionEnabled = YES;
            }
            if (view.type == 2) {
                view.userInteractionEnabled = YES;
            }
        }
    }
}

- (void)animateViewIn:(HITileView *)view
{
    [view animateTo:endRects[view.position]];
}

@end
