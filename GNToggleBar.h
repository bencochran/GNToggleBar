//
//  GNToggleBar.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNGlobal.h"

@class GNToggleItem, GNToggleArrow, GNToggleBackground;

@interface GNToggleBar : UIView <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *_toggleItems;
	NSMutableArray *_quickToggleItems;
	NSMutableArray *_activeToggleItems;
	GNToggleArrow *_arrow;
	GNToggleBackground *_background;
	UITableView *_table;
	
	GNToggleBarState _state;
	CGRect _upFrame;
	CGRect _downFrame;
	CGRect _minimizedFrame;
	
	GNToggleItem *_item;
	
	CGFloat touchYOffset;
	CGPoint touchStartPoint;
	NSTimeInterval previousTouchTimestamp;
	
	BOOL dragging;
}

@property (nonatomic, retain) NSMutableArray *toggleItems;
@property (nonatomic, retain) NSMutableArray *quickToggleItems;
@property (nonatomic, readonly) NSArray *activeToggleItems;
@property (nonatomic, retain) GNToggleArrow *arrow;
@property (nonatomic, retain) GNToggleBackground *background;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic) GNToggleBarState state;
@property (nonatomic) CGRect upFrame;
@property (nonatomic) CGRect downFrame;
@property (nonatomic) CGRect minimizedFrame;
@property (nonatomic, retain) GNToggleItem* item;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame andState:(GNToggleBarState)state;

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(BOOL)active;

- (void)addToggleItem:(GNToggleItem*)item;

@end

////////////////////////////////////////////////////////////

@interface GNToggleArrow : UIView {
	BOOL _pointingUp;
}

@property (nonatomic) BOOL pointingUp;

+ (GNToggleArrow *) arrowPointingUp:(BOOL)pointingUp withFrame:(CGRect)frame;

@end

////////////////////////////////////////////////////////////

@interface GNToggleBackground : UIView {

}

@end