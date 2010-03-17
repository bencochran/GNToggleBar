//
//  GNToggleBarController.m
//  GNToggleBar
//
//  Created by Ben Cochran on 10/26/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import "GNToggleBarController.h"


@implementation GNToggleBarController

@synthesize delegate=_delegate;

- (id)init {
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidToggle:) name:GNToggleItemDidToggle object:nil];
	}
	
	return self;
}

- (void)loadView {
	self.view = [[[GNToggleBar alloc] init] autorelease];
}

- (void)addToggleItem:(GNToggleItem*)item {
	[(GNToggleBar*)self.view addToggleItem:item];
}

- (void)itemDidToggle:(NSNotification *)notification {
	if (self.delegate != nil && [self.delegate respondsToSelector:@selector(toggleBarController:toggleItem:changedToState:)]) {
		[self.delegate toggleBarController:self toggleItem:[notification object] changedToState:[[notification object] active]]; 
	}
}
	 
- (NSArray *)activeToggleItems {
	return [(GNToggleBar*)self.view activeToggleItems];	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end
