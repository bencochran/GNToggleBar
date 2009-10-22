//
//  GNToggleBar.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNToggleItem;

@protocol GNToggleBarDelegate;

@interface GNToggleBar : UIView {
	id<GNToggleBarDelegate> *_delegate;
	NSArray *_toggleItems;
	NSArray *_quickToggleItems;
	NSMutableArray *_activeToggleItems;
	
//	UIImageView *_toggleBarBackgroundImage;
}

@property (nonatomic, assign) id<GNToggleBarDelegate> *delegate;
@property (nonatomic, retain) NSArray *toggleItems;
@property (nonatomic, retain) NSArray *quickToggleItems;
@property (nonatomic, readonly) NSArray *activeToggleItems;
//@property (nonatomic, retain) UIImageView

- (id)initWithFrame:(CGRect)frame;

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(bool)active;

@end

////////////////////////////////////////////////////////////

@protocol GNToggleBarDelegate <NSObject>

- (void)toggleBar:(GNToggleBar *)toggleBar toggleItem:(GNToggleItem *)toggleItem changedToState:(bool)active;

@end