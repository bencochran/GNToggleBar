//
//  GNToggleItem.m
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import "GNToggleItem.h"


@implementation GNToggleItem

@synthesize title=_title, icon=_icon;

- (id)initWithTitle:(NSString *)title andIcon:(NSString *)icon {
	if (self = [self init]) {
		self.title = title;
		self.icon = icon;
	}
	return self;
}

- (id)init {
	if (self = [super init]) {
		_title = nil;
		_icon = nil;
	}
	return self;
}

- (void)setToggleBar:(GNToggleBar *)toggleBar {
	_toggleBar = toggleBar;
}

- (void)dealloc {
	[_title release];
	[_icon release];
	
	[super dealloc];
}

@end
