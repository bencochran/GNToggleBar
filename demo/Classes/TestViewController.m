//
//  TestViewController.m
//  ToggleBarDemo
//
//  Created by Ben Cochran on 10/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TestViewController.h"
#import <GnarusToggleBar/GnarusToggleBar.h>


@implementation TestViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	imageView.image = [UIImage imageNamed:@"bg.jpg"];

	CGRect toggleBounds = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.view.bounds.size.height - 57, self.view.bounds.size.width, 57);

	GNToggleBar *toggleBar = [[GNToggleBar alloc] initWithFrame:toggleBounds];
	[self.view addSubview:toggleBar];
	[toggleBar release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
	[self.view layoutSubviews];
}

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
