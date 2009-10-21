//
//  ToggleBarDemoAppDelegate.m
//  ToggleBarDemo
//
//  Created by Ben Cochran on 10/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ToggleBarDemoAppDelegate.h"
#import "TestViewController.h"
#import <GnarusToggleBar/GnarusToggleBar.h>

@implementation ToggleBarDemoAppDelegate

@synthesize window, viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	//self.viewController = [[[TestViewController alloc] initWithNibName:@"TestView" bundle:nil] retain];
	
	//[window addSubview:viewController.view];
	
	GNToggleBar *toggleBar = [[GNToggleBar alloc] initWithFrame:CGRectMake(0,0,320,480)];
	[window addSubview:toggleBar];
	[toggleBar setNeedsLayout];
	[toggleBar release];
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
