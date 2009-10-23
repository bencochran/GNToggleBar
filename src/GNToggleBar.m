//
//  GNToggleBar.m
//  GNToggleBar
//
//  Created by Ben Cochran on 10/20/09.
//  Copyright 2009 Ben Cochran. All rights reserved.
//

#import "GNToggleBar.h"

@implementation GNToggleBar

@synthesize toggleItems=_toggleItems, quickToggleItems=_quickToggleItems,
			delegate=_delegate, activeToggleItems=_activeToggleItems,
			arrow=_arrow;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		NSLog(@"INIT!");
		_toggleItems = nil;
		_quickToggleItems = nil;
		_activeToggleItems = [[NSMutableArray alloc] init];
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeBottom;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.arrow = [[[GNToggleArrow alloc] init] autorelease];
		[self.arrow setPointingUp:YES];
		[self addSubview:self.arrow];
		NSLog(@"arrow: %@",self.arrow);
		//[self.arrow set
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

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(BOOL)active {
	if (active && [_activeToggleItems indexOfObject:toggleItem] != NSNotFound) {
		[_activeToggleItems addObject:toggleItem];
	} else if (!active) {
		[_activeToggleItems removeObject:toggleItem];
	}
}

- (void)drawToggleBarWithBounds:(CGRect)barBounds inFrame:(CGRect)barFrame arrowUp:(BOOL)arrowUp {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat alignStroke;
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
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, barFrame.origin.x, barFrame.origin.y);
	CGContextClipToRect(context,barBounds);
	CGContextSetAlpha(context, 0.8);
	
	// Bar
	
	alignStroke = 0.0;
	path = CGPathCreateMutable();
	point = CGPointMake(2.0, 8.0);
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((barBounds.size.width/2.0) - 11.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((barBounds.size.width/2.0) - 11.0, 3.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((barBounds.size.width/2.0) - 8.0, 0.0);
	controlPoint1 = CGPointMake((barBounds.size.width/2.0) - 11.0, 1.0);
	controlPoint2 = CGPointMake((barBounds.size.width/2.0) - 10.0, 0.0);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((barBounds.size.width/2.0) + 8.0, 0.0);
	controlPoint1 = CGPointMake((barBounds.size.width/2.0) - 3.0, 0.0);
	controlPoint2 = CGPointMake((barBounds.size.width/2.0) + 3.0, 0.0);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((barBounds.size.width/2.0) + 11.0, 3.0);
	controlPoint1 = CGPointMake((barBounds.size.width/2.0) + 10.0, 0.0);
	controlPoint2 = CGPointMake((barBounds.size.width/2.0) + 11.0, 1.0);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((barBounds.size.width/2.0) + 11.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(barBounds.size.width + 2.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(barBounds.size.width + 2.0, 59.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(-2.0, 59.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(-2.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	CGPathCloseSubpath(path);
	colors = [NSMutableArray arrayWithCapacity:5];
	color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	[colors addObject:(id)[color CGColor]];
	locations[0] = 0.0;
	color = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0];
	[colors addObject:(id)[color CGColor]];
	locations[1] = 1.0;
	color = [UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1.0];
	[colors addObject:(id)[color CGColor]];
	locations[2] = 0.403;
	color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	[colors addObject:(id)[color CGColor]];
	locations[3] = 0.396;
	color = [UIColor colorWithRed:0.231 green:0.231 blue:0.231 alpha:1.0];
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
	color = [UIColor colorWithRed:0.549 green:0.549 blue:0.549 alpha:1.0];
	[color setStroke];
	stroke = 4.0;
	CGContextSetLineWidth(context, stroke);
	CGContextSetLineCap(context, kCGLineCapSquare);
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextEOClip(context);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
	color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	[color setStroke];
	stroke = 2.0;
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

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGRect toggleBarBounds = CGRectMake(0, 0, self.bounds.size.width, 57);
	CGRect toggleBarFrame = CGRectMake(self.bounds.origin.x, self.bounds.size.height - 57, self.bounds.size.width, 57);
	[self drawToggleBarWithBounds:toggleBarBounds inFrame:toggleBarFrame arrowUp:YES];
}

- (void)layoutSubviews {
	//CGRect arrowFrame = CGRectMake((self.bounds.size.width / 2.0) - 3.0, 4.5, 6.0, 5.5);
	CGRect arrowFrame = CGRectMake(self.frame.origin.x + (self.bounds.size.width / 2.0) - 3.0, self.bounds.size.height - 52.5, 6.0, 5.5);
	self.arrow.frame = arrowFrame;
	[self setNeedsDisplay];
	[super layoutSubviews];
}

@end


////////////////////////////////////////////////////////////

@implementation GNToggleArrow

@synthesize pointingUp=_pointingUp;

+ (GNToggleArrow *) arrowPointingUp:(BOOL)pointingUp {
	GNToggleArrow *arrow = [[[GNToggleArrow alloc] init] autorelease];
	[arrow setPointingUp:pointingUp];
	//CGRect bounds = CGRectMake(0, 0, 6, 5.5);
	//arrow.bounds = bounds;
	return arrow;
}

- (id) init {
	if (self = [super init]) {
		self.backgroundColor = [UIColor clearColor];
		self.pointingUp = YES;
	}
	return self;
}

- (void) setPointingUp:(BOOL)pointingUp {
	_pointingUp = pointingUp;
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {

	NSLog(@"button frame:%@", NSStringFromCGRect(self.frame));
	NSLog(@"button boundz:%@", NSStringFromCGRect(self.bounds));
	
//	[[UIColor cyanColor] set];
//	UIRectFill(self.bounds);
//	
//	[[UIColor redColor] set];
//	UIRectFill(self.frame);
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat alignStroke;
	CGMutablePathRef path;
	CGPoint point;
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, self.frame.origin.x, self.frame.origin.y);
	CGContextClipToRect(context,self.bounds);
	CGContextSetAlpha(context, 0.8);
	
	// Arrow
	
	alignStroke = 0.0;
	path = CGPathCreateMutable();
	
	if (self.pointingUp) {
		point = CGPointMake(self.bounds.size.width/2.0, 0.0);
		CGPathMoveToPoint(path, NULL, point.x, point.y);
		point = CGPointMake(0.0, self.bounds.size.height);
		CGPathAddLineToPoint(path, NULL, point.x, point.y);
		point = CGPointMake(self.bounds.size.width, self.bounds.size.height);
		CGPathAddLineToPoint(path, NULL, point.x, point.y);
		point = CGPointMake((self.bounds.size.width/2.0), 0.0);
		CGPathAddLineToPoint(path, NULL, point.x, point.y);
	} else {
		point = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height);
		CGPathMoveToPoint(path, NULL, point.x, point.y);
		point = CGPointMake(0.0, 0.0);
		CGPathAddLineToPoint(path, NULL, point.x, point.y);
		point = CGPointMake(self.bounds.size.width, 0.0);
		CGPathAddLineToPoint(path, NULL, point.x, point.y);
		point = CGPointMake((self.bounds.size.width/2.0), self.bounds.size.height);
		CGPathAddLineToPoint(path, NULL, point.x, point.y);
	}
	
	CGPathCloseSubpath(path);
	
	CGContextSetShadow(context,CGSizeMake(1.0, -1.0), 1.0);	
	
	color = [UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1.0];
	[color setFill];
	CGContextAddPath(context, path);
	CGContextFillPath(context);	
	
	CGPathRelease(path);

	CGContextRestoreGState(context);
	CGColorSpaceRelease(space);
}

@end