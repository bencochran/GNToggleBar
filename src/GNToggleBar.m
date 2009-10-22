//
//  GNToggleBar.m
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import "GNToggleBar.h"

const CGFloat kGNToggleBarWidth = 320.0;
const CGFloat kGNToggleBarHeight = 480.0;

@implementation GNToggleBar

@synthesize toggleItems=_toggleItems, quickToggleItems=_quickToggleItems,
			delegate=_delegate, activeToggleItems=_activeToggleItems;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		NSLog(@"INIT!");
		_toggleItems = nil;
		_quickToggleItems = nil;
		_activeToggleItems = [[NSMutableArray alloc] init];
		self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc {
	[_toggleItems release];
	[_quickToggleItems release];
	[_activeToggleItems release];
	
    [super dealloc];
}

- (void)setToggleItems:(NSArray *)toggleItems {
	[_toggleItems release];
	_toggleItems = [toggleItems retain];
	
	[_activeToggleItems removeAllObjects];
	
	[self setNeedsLayout];
}

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(bool)active {
	if (active && [_activeToggleItems indexOfObject:toggleItem] != NSNotFound) {
		[_activeToggleItems addObject:toggleItem];
	} else if (!active) {
		[_activeToggleItems removeObject:toggleItem];
	}
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"DRAWING");
	
//	CGRect bounds = [self bounds];
//	
//	[[UIColor grayColor] set];
//	UIRectFill(bounds);
//	
//	CGRect square = CGRectMake(10, 10, 50, 100);
//	[[UIColor blueColor] set];
//	UIRectFill(square);
//	
//	[[UIColor blackColor] set];
//	UIRectFrame(square);
	//UIImage *image = [UIImage imageNamed:@"ToggleBarBackground.png"];
	 
	//[self addSubview:image];
	//[image drawInRect:CGRectMake(0, 423, 320, 57)];
	
	CGRect imageBounds = CGRectMake(0.0, 0.0, kGNToggleBarWidth, kGNToggleBarHeight);
	CGRect bounds = [self bounds];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat alignStroke;
	CGFloat resolution;
	CGMutablePathRef path;
	CGPoint point;
	CGPoint controlPoint1;
	CGPoint controlPoint2;
	CGGradientRef gradient;
	NSMutableArray *colors;
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGAffineTransform transform;
	CGMutablePathRef tempPath;
	CGRect pathBounds;
	CGPoint point2;
	CGFloat stroke;
	CGFloat locations[5];
	resolution = 0.5 * (bounds.size.width / imageBounds.size.width + bounds.size.height / imageBounds.size.height);
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, bounds.origin.x, bounds.origin.y);
	CGContextScaleCTM(context, (bounds.size.width / imageBounds.size.width), (bounds.size.height / imageBounds.size.height));
	
	// Layer 1
	
	alignStroke = 0.0;
	path = CGPathCreateMutable();
	point = CGPointMake(-2.0, 431.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(149.0, 431.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(149.0, 426.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(152.0, 423.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(149.0, 424.0);
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	controlPoint2 = CGPointMake(150.0, 423.0);
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(168.0, 423.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(152.0, 423.0);
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	controlPoint2 = CGPointMake(168.0, 423.0);
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(171.0, 426.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(170.0, 423.0);
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	controlPoint2 = CGPointMake(171.0, 424.0);
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(171.0, 431.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(322.0, 431.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(322.0, 482.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(-2.0, 482.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(-2.0, 431.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	CGPathCloseSubpath(path);
	colors = [NSMutableArray arrayWithCapacity:5];
	color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
	[colors addObject:(id)[color CGColor]];
	locations[0] = 0.0;
	color = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:0.8];
	[colors addObject:(id)[color CGColor]];
	locations[1] = 1.0;
	color = [UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:0.8];
	[colors addObject:(id)[color CGColor]];
	locations[2] = 0.403;
	color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
	[colors addObject:(id)[color CGColor]];
	locations[3] = 0.396;
	color = [UIColor colorWithRed:0.231 green:0.231 blue:0.231 alpha:0.8];
	[colors addObject:(id)[color CGColor]];
	locations[4] = 0.838;
	gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextEOClip(context);
	transform = CGAffineTransformMakeRotation(1.571);
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
	color = [UIColor colorWithRed:0.549 green:0.549 blue:0.549 alpha:0.6];
	[color setStroke];
	stroke = 2.0;
	stroke *= resolution;
	if (stroke < 1.0)
		stroke = ceil(stroke);
	else
		stroke = round(stroke);
	stroke /= resolution;
	stroke *= 2.0;
	CGContextSetLineWidth(context, stroke);
	CGContextSetLineCap(context, kCGLineCapSquare);
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextEOClip(context);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.73];
	[color setStroke];
	stroke = 1.0;
	stroke *= resolution;
	if (stroke < 1.0)
		stroke = ceil(stroke);
	else
		stroke = round(stroke);
	stroke /= resolution;
	stroke *= 2.0;
	CGContextSetLineWidth(context, stroke);
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextEOClip(context);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	CGPathRelease(path);
	// Oh, I'm bad.
	//NSLog(@"Unregistered Copy of Opacity");
	
	CGContextRestoreGState(context);
	CGColorSpaceRelease(space);
}

@end
