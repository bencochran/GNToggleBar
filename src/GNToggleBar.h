//
//  GNToggleBar.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNToggleItem, GNToggleArrow, GNToggleBackground;

@protocol GNToggleBarDelegate;

@interface GNToggleBar : UIView {
	id<GNToggleBarDelegate> *_delegate;
	NSArray *_toggleItems;
	NSArray *_quickToggleItems;
	NSMutableArray *_activeToggleItems;
	GNToggleArrow *_arrow;
	GNToggleBackground *_background;
	UITableView *_table;
}

@property (nonatomic, assign) id<GNToggleBarDelegate> *delegate;
@property (nonatomic, retain) NSArray *toggleItems;
@property (nonatomic, retain) NSArray *quickToggleItems;
@property (nonatomic, readonly) NSArray *activeToggleItems;
@property (nonatomic, retain) GNToggleArrow *arrow;
@property (nonatomic, retain) GNToggleBackground *background;
@property (nonatomic, retain) UITableView *table;

- (id)initWithFrame:(CGRect)frame;

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(BOOL)active;

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

////////////////////////////////////////////////////////////

@protocol GNToggleBarDelegate <NSObject>

- (void)toggleBar:(GNToggleBar *)toggleBar toggleItem:(GNToggleItem *)toggleItem changedToState:(BOOL)active;

@end
