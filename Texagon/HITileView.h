//
//  HITileView.h
//  SST Tiles
//
//  Created by Ravern Koh on 31/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HITileView : UIImageView

#define HITileViewLongType 0
#define HITileViewTapType 1
#define HITileViewSwipeType 2

@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger position;
@property (strong, nonatomic) id target;
@property (assign, nonatomic) SEL selector;

- (void)animateTo:(CGRect)rect;

@end
