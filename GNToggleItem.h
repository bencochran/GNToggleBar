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
	NSString* _title;
	UIImage* _image;
	GNToggleBar* _toggleBar;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIImage *image;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

@end