//
//  GNToggleBar.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNToggleItem.h"

@protocol GNToggleBarDelegate;

@interface GNToggleBar : UIView {
	id<GNToggleBarDelegate> *_delegate;
	NSArray *_toggleItems;
	NSArray *_quickToggleItems;
}

@property (nonatomic, assign) id<GNToggleBarDelegate> *delegate;
@property (nonatomic, retain) NSArray *toggleItems;
@property (nonatomic, retain) NSArray *quickToggleItems;

@end

////////////////////////////////////////////////////////////

@protocol GNToggleBarDelegate <NSObject>

- (void)toggleBar:(GNToggleBar *)toggleBar toggleItem:(GNToggleItem *)toggleItem changedToState:(bool)active;

@end