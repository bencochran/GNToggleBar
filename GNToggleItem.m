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

@synthesize title=_title, image=_image;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
	if (self = [self init]) {
		self.title = title;
		self.image = image;
		self.backgroundColor = [UIColor clearColor];

		UIImageView *tempImageView = [[UIImageView alloc] initWithImage:self.image];
		tempImageView.center = CGPointMake(15,15);
		[tempImageView.layer removeFromSuperlayer];
		self.layer.mask = tempImageView.layer;
		[tempImageView release];
	}
	return self;
}

- (id)init {
	if (self = [super init]) {
		_title = nil;
		_image = nil;
	}
	return self;
}

- (void)setToggleBar:(GNToggleBar *)toggleBar {
	_toggleBar = toggleBar;
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
//	CGContextTranslateCTM(context, self.bounds.origin.x, bounds.origin.y);
//	CGContextScaleCTM(context, (bounds.size.width / imageBounds.size.width), (bounds.size.height / imageBounds.size.height));
	
	// Layer 1
	
	path = CGPathCreateMutable();
	drawRect = CGRectMake(0.0, 0.0, 30.0, 30.0);
	CGPathAddRect(path, NULL, drawRect);
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
	gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextEOClip(context);
	transform = CGAffineTransformMakeRotation(-1.222);
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
	NSLog(@"Unregistered Copy of Opacity");
	
	CGContextRestoreGState(context);
	CGColorSpaceRelease(space);
}

- (void)dealloc {
	[_title release];
	[_image release];
	
	[super dealloc];
}

@end
