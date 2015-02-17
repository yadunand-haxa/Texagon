//
//  HITileView.m
//  SST Tiles
//
//  Created by Ravern Koh on 31/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HITileView.h"
#import "HITheme.h"
#import "HIConstants.h"

@implementation HITileView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.type == HITileViewTapType) {
        self.image = [UIImage imageNamed:@"red_selected.png"];
    } else if (self.type == HITileViewSwipeType) {
        self.image = [UIImage imageNamed:@"blue_selected.png"];
    } else if (self.type == HITileViewLongType) {
        self.image = [UIImage imageNamed:@"gray_selected.png"];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.type == HITileViewTapType) {
        self.image = [UIImage imageNamed:@"red.png"];
    } else if (self.type == HITileViewSwipeType) {
        self.image = [UIImage imageNamed:@"blue.png"];
    } else if (self.type == HITileViewLongType) {
        self.image = [UIImage imageNamed:@"gray.png"];
    }
}

- (void)setType:(NSInteger)type
{
    _type = type;
    self.gestureRecognizers = [NSArray new];
    
    if (type == HITileViewLongType) {
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileLongPressed:)];
        gr.numberOfTapsRequired = 2;
        [self addGestureRecognizer:gr];
    } else if (type == HITileViewTapType) {
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileTapped:)];
        [self addGestureRecognizer:gr];
    } else if (type == HITileViewSwipeType) {
//        UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//        gr.direction = UISwipeGestureRecognizerDirectionDown;
//        [self addGestureRecognizer:gr];
//        switch (self.position) {
//            case 0:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionLeft;
//                [self addGestureRecognizer:gr];
//                UISwipeGestureRecognizer *gr2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr2.direction = UISwipeGestureRecognizerDirectionUp;
//                [self addGestureRecognizer:gr2];
//                break;
//            }
//                
//            case 1:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionUp;
//                [self addGestureRecognizer:gr];
//                break;
//            }
//                
//            case 2:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionUp;
//                [self addGestureRecognizer:gr];
//                UISwipeGestureRecognizer *gr2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr2.direction = UISwipeGestureRecognizerDirectionRight;
//                [self addGestureRecognizer:gr2];
//                break;
//            }
//                
//            case 3:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionLeft;
//                [self addGestureRecognizer:gr];
//                break;
//            }
//                
//            case 4:
//            {
                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
                gr.direction = UISwipeGestureRecognizerDirectionLeft;
                [self addGestureRecognizer:gr];
                UISwipeGestureRecognizer *gr2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
                gr2.direction = UISwipeGestureRecognizerDirectionRight;
                [self addGestureRecognizer:gr2];
                UISwipeGestureRecognizer *gr3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
                gr3.direction = UISwipeGestureRecognizerDirectionUp;
                [self addGestureRecognizer:gr3];
                UISwipeGestureRecognizer *gr4 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
                gr4.direction = UISwipeGestureRecognizerDirectionDown;
                [self addGestureRecognizer:gr4];
//                break;
//            }
//                
//            case 5:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionRight;
//                [self addGestureRecognizer:gr];
//                break;
//            }
//                
//            case 6:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionLeft;
//                [self addGestureRecognizer:gr];
//                UISwipeGestureRecognizer *gr2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr2.direction = UISwipeGestureRecognizerDirectionDown;
//                [self addGestureRecognizer:gr2];
//                break;
//            }
//                
//            case 7:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionDown;
//                [self addGestureRecognizer:gr];
//                break;
//            }
//                
//            case 8:
//            {
//                UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr.direction = UISwipeGestureRecognizerDirectionRight;
//                [self addGestureRecognizer:gr];
//                UISwipeGestureRecognizer *gr2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target action:@selector(tileSwiped:)];
//                gr2.direction = UISwipeGestureRecognizerDirectionDown;
//                [self addGestureRecognizer:gr2];
//                break;
//            }
//                
//            default:
//                break;
//        }
//    }
    }
    if (self.type == HITileViewLongType) {
        self.image = [UIImage imageNamed:@"gray.png"];
    } else if (self.type == HITileViewTapType) {
        self.image = [UIImage imageNamed:@"red.png"];
    } else {
        self.image = [UIImage imageNamed:@"blue.png"];
    }
}

- (void)animateTo:(CGRect)rect
{
    [UIView animateWithDuration:HITileViewAnimationTime animations:^{
        self.frame = rect;
    }];
}

- (void)tileLongPressed:(UITapGestureRecognizer *)sender
{
    
}

- (void)tileSwiped:(UITapGestureRecognizer *)sender
{
    
}

- (void)tileTapped:(UITapGestureRecognizer *)sender
{
    
}

@end
