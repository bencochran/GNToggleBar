//
//  GNToggleItem.m
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import "GNToggleItem.h"
#import <QuartzCore/QuartzCore.h>


@implementation GNToggleItem

@synthesize label=_label, icon=_icon;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
	if (self = [self init]) {
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;

		// Set up and add the icon view
		self.icon = [[GNToggleIcon alloc] initWithImage:image];
		self.icon.frame = CGRectMake(0, 2, self.bounds.size.width, 30);
		self.icon.center = CGPointMake(self.bounds.size.width / 2, 15);
		[self addSubview:self.icon];
		
		// Set up and add the label view
		CGRect labelFrame = CGRectMake(0, 31, self.bounds.size.width, 14);
		self.label = [[UILabel alloc] initWithFrame:labelFrame];
		self.label.backgroundColor = [UIColor clearColor];
		self.label.text = title;
		self.label.textColor = [UIColor whiteColor];
		self.label.shadowColor = [UIColor blackColor];
		self.label.shadowOffset = CGSizeMake(0, -1);
		self.label.lineBreakMode = UILineBreakModeMiddleTruncation;
		self.label.font = [UIFont boldSystemFontOfSize:10];		
		self.label.textAlignment = UITextAlignmentCenter;
		[self addSubview:self.label];		
	}
	return self;
}

- (id)init {
	if (self = [super init]) {
		_label = nil;
		_icon = nil;
	}
	return self;
}

- (void)setToggleBar:(GNToggleBar *)toggleBar {
	_toggleBar = toggleBar;
}

- (void)layoutSubviews {
	// Reposition the icon and label
	self.icon.frame = CGRectMake(0, 2, self.bounds.size.width, 30);
	self.icon.center = CGPointMake(self.bounds.size.width / 2, 15);
	
	CGRect labelFrame = CGRectMake(0, 31, self.bounds.size.width, 14);
	self.label.frame = labelFrame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	// Simply toggle our active state and redraw
	self.icon.active = !self.icon.active;
	[self.icon setNeedsDisplay];
	
	// In the future, we'll call our delegate here and inform it of
	// a state change.
}

- (void)dealloc {
	[_label release];
	[_icon release];
	
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////

@implementation GNToggleIcon

@synthesize image=_image, active=_active;

-(id) initWithImage:(UIImage *)image {
	if (self = [super init]) {
		self.image = image;
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;
		self.active = NO;
		
		// Make an UIImageView of our image and use its layer
		// as this layer's mask. There's probably a less resource
		// intensive and easier way to do this.
		UIImageView *tempImageView = [[UIImageView alloc] initWithImage:self.image];
		tempImageView.center = self.center;
		[tempImageView.layer removeFromSuperlayer];
		self.layer.mask = tempImageView.layer;
		[tempImageView release];
	}
	return self;
}

- (void)layoutSubviews {
	// Redo the mask to make sure it sits in the center
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:self.image];
	tempImageView.center = self.center;
	[tempImageView.layer removeFromSuperlayer];
	self.layer.mask = tempImageView.layer;
	[tempImageView release];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGMutablePathRef path;
	CGRect drawRect;
	CGGradientRef gradient;
	NSMutableArray *colors;
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGAffineTransform transform;
	CGMutablePathRef tempPath;
	CGRect pathBounds;
	CGPoint point;
	CGPoint point2;
	CGFloat locations[4];
	
	CGContextSaveGState(context);
	
	path = CGPathCreateMutable();
	drawRect = CGRectMake(self.bounds.size.width / 2 - 15, 0.0, 30.0, 30.0);
	CGPathAddRect(path, NULL, drawRect);
	
	if (self.active) {
		colors = [NSMutableArray arrayWithCapacity:4];
		color = [UIColor colorWithRed:0.835 green:0.882 blue:0.976 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		locations[0] = 0.0;
		color = [UIColor colorWithRed:0.263 green:0.753 blue:0.965 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		locations[1] = 1.0;
		color = [UIColor colorWithRed:0.384 green:0.741 blue:0.957 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		locations[2] = 0.626;
		color = [UIColor colorWithRed:0.208 green:0.561 blue:0.867 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		locations[3] = 0.633;
		transform = CGAffineTransformMakeRotation(-1.222);
	} else {
		colors = [NSMutableArray arrayWithCapacity:2];
		color = [UIColor colorWithRed:0.3647 green:0.3647 blue:0.3647 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		locations[0] = 0.0;
		color = [UIColor colorWithRed:0.6392 green:0.6392 blue:0.6392 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		locations[1] = 1.0;
		transform = CGAffineTransformMakeRotation(1.570796326794897);
	}

	
	gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextEOClip(context);
	tempPath = CGPathCreateMutable();
	CGPathAddPath(tempPath, &transform, path);
	pathBounds = CGPathGetBoundingBox(tempPath);
	point = pathBounds.origin;
	point2 = CGPointMake(CGRectGetMaxX(pathBounds), CGRectGetMinY(pathBounds));
	transform = CGAffineTransformInvert(transform);
	point = CGPointApplyAffineTransform(point, transform);
	point2 = CGPointApplyAffineTransform(point2, transform);
	CGPathRelease(tempPath);
	CGContextDrawLinearGradient(context, gradient, point, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	CGContextRestoreGState(context);
	CGGradientRelease(gradient);
	CGPathRelease(path);
	// I should probably pay for Opacity.app...
	//NSLog(@"Unregistered Copy of Opacity");
	
	CGContextRestoreGState(context);
	CGColorSpaceRelease(space);
}

@end