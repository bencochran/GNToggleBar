//
//  GNToggleBar.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNToggleItem, GNToggleArrow;

@protocol GNToggleBarDelegate;

@interface GNToggleBar : UIView {
	id<GNToggleBarDelegate> *_delegate;
	NSArray *_toggleItems;
	NSArray *_quickToggleItems;
	NSMutableArray *_activeToggleItems;
	GNToggleArrow *_arrow;
}

@property (nonatomic, assign) id<GNToggleBarDelegate> *delegate;
@property (nonatomic, retain) NSArray *toggleItems;
@property (nonatomic, retain) NSArray *quickToggleItems;
@property (nonatomic, readonly) NSArray *activeToggleItems;
@property (nonatomic, retain) GNToggleArrow *arrow;

- (id)initWithFrame:(CGRect)frame;

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(BOOL)active;

@end


////////////////////////////////////////////////////////////

@interface GNToggleArrow : UIControl {
	BOOL _pointingUp;
}

@property (nonatomic) BOOL pointingUp;

+ (GNToggleArrow *) arrowPointingUp:(BOOL)pointingUp;

@end

////////////////////////////////////////////////////////////

@protocol GNToggleBarDelegate <NSObject>

- (void)toggleBar:(GNToggleBar *)toggleBar toggleItem:(GNToggleItem *)toggleItem changedToState:(BOOL)active;

@end