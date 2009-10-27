//
//  GNToggleItem.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GNGlobal.h"

@class GNToggleBar;

@interface GNToggleItem : UIButton {
	NSString *_title;
	NSString *_icon;
	GNToggleBar *_toggleBar;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (id)initWithTitle:(NSString *)title andIcon:(NSString *)icon;

@end