//
//  GNToggleBar.h
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GNToggleBar : UIView {
	NSArray *_toggleItems;
	NSArray *_quickToggleItems;
}

@property (nonatomic, retain) NSArray *toggleItems;
@property (nonatomic, retain) NSArray *quickToggleItems;

@end
