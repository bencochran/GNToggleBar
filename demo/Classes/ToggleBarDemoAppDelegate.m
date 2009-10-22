//
//  ToggleBarDemoAppDelegate.m
//  ToggleBarDemo
//
//  Created by Ben Cochran on 10/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ToggleBarDemoAppDelegate.h"
#import "TestViewController.h"

@implementation ToggleBarDemoAppDelegate

@synthesize window, viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {  
	[application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	
	self.viewController = [[TestViewController alloc] initWithNibName:@"TestView" bundle:nil];
	[window addSubview:viewController.view];
	// Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[viewController release];
    [window release];
    [super dealloc];
}


@end
