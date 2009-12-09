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

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	//CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	//CGRect fullFrame = CGRectMake(appFrame.origin.x, appFrame.origin.y + appFrame.size.height - 58, appFrame.size.width, 58);

	self.view = [[[GNToggleBar alloc] init] autorelease];
}

- (void)addQuickToggleItem:(GNToggleItem*)item {
	[item addTarget:self action:@selector(itemDidToggle:) forControlEvents:UIControlEventTouchUpInside];
	[(GNToggleBar*)self.view addQuickToggleItem:item];
}

- (void)itemDidToggle:(GNToggleItem *)item {
	if (self.delegate != nil && [self.delegate respondsToSelector:@selector(toggleBarController:toggleItem:changedToState:)]) {
		[self.delegate toggleBarController:self toggleItem:item changedToState:item.icon.active]; 
	}
	//	if ([self.delegate ]) {
//		
//	}
	NSLog(@"event!: %@", item);
}
	 
- (NSArray *)activeToggleItems {
	return [(GNToggleBar*)self.view activeToggleItems];	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
