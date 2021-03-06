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

@class GNToggleBar, GNToggleIcon, GNQuickToggleItemView,
	   GNToggleItemTableViewCell;

@interface GNToggleItem : NSObject <NSCopying> {
	GNQuickToggleItemView *_quickView;
	GNToggleItemTableViewCell *_tableCell;
	BOOL _active;
	GNToggleBar* _toggleBar;
	GNToggleIcon *_icon;
	NSString *_title;
	UIImage *_image;

}

@property (nonatomic, readonly) GNQuickToggleItemView *quickView;
@property (nonatomic, retain) IBOutlet GNToggleItemTableViewCell *tableCell;
@property (nonatomic, readonly) GNToggleIcon *icon;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic) BOOL active;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

@end

////////////////////////////////////////////////////////////

@interface GNQuickToggleItemView : UIControl {
	GNToggleIcon *_icon;
	UILabel *_label;
	GNToggleItem *_item;
	BOOL isTouching;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) GNToggleIcon *icon;
@property (nonatomic, assign) GNToggleItem *item;

+ (GNQuickToggleItemView *)viewForItem:(GNToggleItem *)item;

- (id)initWithItem:(GNToggleItem *)item;;

@end

////////////////////////////////////////////////////////////

extern NSString *const GNToggleItemDidToggle;

@interface GNToggleItemTableViewCell : UITableViewCell {
	GNToggleItem *_item;
	UIView *cellContentView;
//	GNToggleIcon *_icon;
//	UILabel *_label;
}

@property (nonatomic, assign) GNToggleItem *item;
//@property (nonatomic, retain) GNToggleIcon *icon;
//@property (nonatomic, retain) UILabel *label;

+ (GNToggleItemTableViewCell *)cellForItem:(GNToggleItem *)item;

@end


////////////////////////////////////////////////////////////

@interface GNToggleIcon : UIView {
	UIImage* _image;
	GNToggleItem *_item;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) GNToggleItem *item;

- (id)initWithItem:(GNToggleItem *)item;

@end
