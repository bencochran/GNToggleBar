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

@class GNToggleBar, GNToggleIcon;

@interface GNToggleItem : UIButton {
	GNToggleIcon* _icon;
	UILabel* _label;
	
	GNToggleBar* _toggleBar;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) GNToggleIcon *icon;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

@end

////////////////////////////////////////////////////////////

@interface GNToggleIcon : UIView {
	UIImage* _image;
	BOOL _active;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic) BOOL active;

- (id)initWithImage:(UIImage *)image;

@end
