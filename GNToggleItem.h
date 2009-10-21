//
//  GNToggleItem.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNToggleItem : NSObject {
	NSString *_title;
	NSString *_icon;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (id)initWithTitle:(NSString *)title andIcon:(NSString *)icon;

@end