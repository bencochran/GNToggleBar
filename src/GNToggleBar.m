//
//  GNToggleBar.m
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import "GNToggleBar.h"


@implementation GNToggleBar

@synthesize toggleItems=_toggleItems, quickToggleItems=_quickToggleItems,
			delegate=_delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[_toggleItems release];
	[_quickToggleItems release];
	
    [super dealloc];
}


@end
