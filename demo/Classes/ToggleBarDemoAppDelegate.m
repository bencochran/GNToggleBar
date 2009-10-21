//
//  ToggleBarDemoAppDelegate.m
//  ToggleBarDemo
//
//  Created by Ben Cochran on 10/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ToggleBarDemoAppDelegate.h"

@implementation ToggleBarDemoAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
