//
//  GNToggleBarController.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/26/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNGlobal.h"

@protocol GNToggleBarDelegate;

@interface GNToggleBarController : UIViewController {
	NSObject<GNToggleBarDelegate> *_delegate;
}

@property (nonatomic, assign) NSObject<GNToggleBarDelegate> *delegate;
@property (nonatomic, readonly) NSArray *activeToggleItems;

- (void)addQuickToggleItem:(GNToggleItem*)item;

@end

////////////////////////////////////////////////////////////

@protocol GNToggleBarDelegate <NSObject>

- (void)toggleBarController:(GNToggleBarController *)toggleBarController toggleItem:(GNToggleItem *)toggleItem changedToState:(BOOL)active;

@end

