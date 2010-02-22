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
			activeToggleItems=_activeToggleItems,
			arrow=_arrow, background=_background, table=_table,
			upFrame=_upFrame, downFrame=_downFrame, minimizedFrame=_minimizedFrame,
			state=_state, item=_item;

- (id)init {
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	CGRect fullFrame = CGRectMake(appFrame.origin.x, appFrame.origin.y + appFrame.size.height - 58, appFrame.size.width, 58);
	return [self initWithFrame:fullFrame];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		self.toggleItems = [NSMutableArray array];
		self.quickToggleItems = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
		_activeToggleItems = [[NSMutableArray alloc] init];
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		self.alpha = 0.8;
		
		UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 57, frame.size.width, 0)];
		bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		bgView.backgroundColor = [UIColor blackColor];
		[self addSubview:bgView];
		[bgView release];
		
		
		self.downFrame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - 57, frame.size.width, 57);
		self.upFrame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - 275, frame.size.width, 275);
		self.minimizedFrame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - 10, frame.size.width, 10);
		
		self.state = GNToggleBarStateDown;
		
		CGRect backgroundFrame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 58);
		self.background = [[[GNToggleBackground alloc] initWithFrame:backgroundFrame] autorelease];
		[self addSubview:self.background];
		
		CGRect arrowFrame = CGRectMake(self.frame.origin.x + (self.bounds.size.width / 2.0) - 3.0, self.bounds.origin.y + 4.5, 6.0, 5.5);
		self.arrow = [[[GNToggleArrow alloc] initWithFrame:arrowFrame] autorelease];
		[self.arrow setPointingUp:YES];
		[self addSubview:self.arrow];
		
		CGRect tableFrame = CGRectMake(self.frame.origin.x, self.bounds.origin.y + 58, self.bounds.size.width, self.bounds.size.height-58);
		if (tableFrame.size.height > 275) {
			tableFrame.size.height = 275;
		}		
		self.table = [[[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain] autorelease];
		self.table.backgroundColor = [UIColor clearColor];
		self.table.separatorColor = [UIColor colorWithRed:0.549 green:0.549 blue:0.549 alpha:1.0];
		
		self.table.delegate = self;
		self.table.dataSource = self;
		[self.table setEditing:YES animated:NO];
		[self addSubview:self.table];
		
//		CGRect itemFrame = CGRectMake(self.bounds.origin.x + 4, self.bounds.origin.y + 4, self.bounds.size.width/5, 44);
//		self.item = [[GNToggleItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"food.png"]];
//		self.item.frame = itemFrame;
//		[self addSubview:self.item];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andState:(GNToggleBarState)state {
	if (self = [self initWithFrame:frame]) {
		self.state = state;
	}
	return self;
}

- (void)dealloc {
	[_toggleItems release];
	[_quickToggleItems release];
	[_activeToggleItems release];
	[_arrow release];
	[_background release];
	
    [super dealloc];
}

- (void)setToggleItems:(NSMutableArray *)toggleItems {
	[_toggleItems release];
	_toggleItems = [toggleItems retain];
	
	[_activeToggleItems removeAllObjects];
	
	[self setNeedsLayout];
}

- (void)addToggleItem:(GNToggleItem*)item {
	[self.toggleItems addObject:item];
	if ([self.quickToggleItems count] < 5) {
		[self.quickToggleItems addObject:item];
	}
	[self addSubview:item.quickView];
	[self.table reloadData];
}

- (void)setStateForToggleItem:(GNToggleItem *)toggleItem active:(BOOL)active {
	if (active && [_activeToggleItems indexOfObject:toggleItem] != NSNotFound) {
		[_activeToggleItems addObject:toggleItem];
	} else if (!active) {
		[_activeToggleItems removeObject:toggleItem];
	}
}

- (void)setState:(GNToggleBarState)state {
	_state = state;
	switch (state) {
		case GNToggleBarStateUp:
			self.frame = self.upFrame;
			[self.arrow setPointingUp:NO];
			break;
		case GNToggleBarStateMinimized:
			self.frame = self.minimizedFrame;
			[self.arrow setPointingUp:YES];
			break;
		case GNToggleBarStateDown:
		default:
			self.frame = self.downFrame;
			[self.arrow setPointingUp:YES];
			break;
	}
}

- (void)layoutSubviews {
	self.downFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - 57, self.frame.size.width, 57);
	self.upFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - 275, self.frame.size.width, 275);
	self.minimizedFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - 10, self.frame.size.width, 10);
	
	
	CGRect arrowFrame = CGRectMake(self.bounds.origin.x + (self.bounds.size.width / 2.0) - 3.0, self.bounds.origin.y + 4.5, 6.0, 5.5);
	self.arrow.frame = arrowFrame;
	
	CGRect backgroundFrame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 58);
	self.background.frame = backgroundFrame;
	
	CGRect itemFrame;
	NSUInteger i, count = [self.quickToggleItems count];
	
	CGFloat width = (self.bounds.size.width - 8)/self.quickToggleItems.count;
	
	for (i = 0; i < count; i++) {
		GNToggleItem *item = [self.quickToggleItems objectAtIndex:i];
		itemFrame = CGRectMake(floor(self.bounds.origin.x + 4 + width * i), self.bounds.origin.y + 11, floor(width), 44);
		item.quickView.frame = itemFrame;
	}
	
//	for (GNToggleItem *item in self.quickToggleItems) {
//		itemFrame = CGRectMake(self.bounds.origin.x + 4, self.bounds.origin.y + 4, self.bounds.size.width/5, 44);
//		//		self.item = [[GNToggleItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"food.png"]];
//		//		self.item.frame = itemFrame;
//		//		[self addSubview:self.item];
//		
//	}
	
//	CGRect itemFrame = CGRectMake(self.bounds.origin.x + 4, self.bounds.origin.y + 11, self.bounds.size.width/5, 45);
//	self.item.frame = itemFrame;
	
	CGRect tableFrame = CGRectMake(self.frame.origin.x, self.bounds.origin.y + 58, self.bounds.size.width, self.bounds.size.height-58);
	
	if (tableFrame.size.height > 275) {
		tableFrame.size.height = 275;
	}
	
	self.table.frame = tableFrame;
	
	[super layoutSubviews];
}

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	/*
	 * We want the touchable area to be quite a bit larger than
	 * the very small arrow itself, so let's test againsts something
	 * larger than the bounds.
	 */
	CGRect touchableArrow = CGRectMake(self.arrow.frame.origin.x-20, self.arrow.frame.origin.y-20, self.arrow.frame.size.width+40, self.arrow.frame.size.height+35);
	return CGRectContainsPoint(self.bounds, point) || CGRectContainsPoint(touchableArrow, point);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	UIView *tableSubView = [self.table hitTest:[self convertPoint:point toView:self.table] withEvent:event];
	if (tableSubView) {
		return tableSubView;
	} else {
		return [self pointInside:point withEvent:event] ? self : nil;
	}
}

- (void)startDragging:(NSSet *)touches {
	UITouch *touch = [touches anyObject];
	UIView *view;
	if ([touch phase] == UITouchPhaseStationary) {
		CGPoint locationInSuperview = [touch locationInView:[self superview]];
		if (touchStartPoint.y - locationInSuperview.y == 0 && touchStartPoint.x - locationInSuperview.x == 0) {
			dragging = YES;
			self.alpha = 0.7;
			
			for (GNToggleItem *item in self.quickToggleItems) {
				if (view = [item.quickView hitTest:[touch locationInView:item.quickView] withEvent:nil]) {
					[view touchesCancelled:touches withEvent:nil];
				}
			}
		}
	}	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	UIView *view;
	if ([self.arrow hitTest:[touch locationInView:self.arrow] withEvent:event]) {
		dragging = NO;
		touchYOffset = [touch locationInView:self].y;
		touchStartPoint = [touch locationInView:[self superview]];
		[self performSelector:@selector(startDragging:) withObject:touches afterDelay:0.15];
	}
	for (GNToggleItem *item in self.quickToggleItems) {
		if (view = [item.quickView hitTest:[touch locationInView:item.quickView] withEvent:event]) {
			[view touchesBegan:touches withEvent:event];
		}
	}
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	if (dragging) {
		CGFloat newY = [touch locationInView:[self superview]].y - touchYOffset;
		CGFloat newHeight = [[self superview] bounds].size.height - newY;
		CGRect newFrame = CGRectMake(self.frame.origin.x, newY, self.frame.size.width, newHeight);

		if (newHeight > self.minimizedFrame.size.height) {
			self.frame = newFrame;
		}
	}	
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	UIView *view;
	if (dragging) {
		self.alpha = 0.8;
		dragging = NO;
		
		CGPoint location = [touch locationInView:self.superview];
		
		switch (self.state) {
			case GNToggleBarStateUp:
				if (location.y > self.upFrame.origin.y + 80) {
					self.state = GNToggleBarStateDown;
				} else {
					self.state = GNToggleBarStateUp;
				}
				break;
			case GNToggleBarStateMinimized:
				self.state = GNToggleBarStateDown;
				break;
			case GNToggleBarStateDown:
				if (location.y < self.downFrame.origin.y - 30) {
					self.state = GNToggleBarStateUp;
				} else if (location.y > self.downFrame.origin.y + 40) {
					self.state = GNToggleBarStateMinimized;
				} else {
					self.state = GNToggleBarStateDown;
				}
				break;
			default:
				self.state = GNToggleBarStateUp;
				break;
		}
	} else {
		for (GNToggleItem *item in self.quickToggleItems) {
			if (view = [item.quickView hitTest:[touch locationInView:item.quickView] withEvent:event]) {
				[view touchesEnded:touches withEvent:event];
			}
		}
	}
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	UIView *view;
	if (dragging) {
		dragging = NO;
		self.alpha = 0.8;
		// Jump back to previous state (up/down/minimized)
	} else {
		for (GNToggleItem *item in self.quickToggleItems) {
			if (view = [item.quickView hitTest:[touch locationInView:item.quickView] withEvent:event]) {
				[view touchesCancelled:touches withEvent:event];
			}
		}
	}
}

#pragma mark Table View Delegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {	
	return NO;
}

#pragma mark Table View Data Source

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	[self.toggleItems exchangeObjectAtIndex:toIndexPath.row	withObjectAtIndex:fromIndexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.toggleItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [[self.toggleItems objectAtIndex:indexPath.row] tableCell];
}

@end

////////////////////////////////////////////////////////////

@implementation GNToggleArrow

@synthesize pointingUp=_pointingUp;

+ (GNToggleArrow *) arrowPointingUp:(BOOL)pointingUp withFrame:(CGRect)frame {
	GNToggleArrow *arrow = [[[GNToggleArrow alloc] initWithFrame:frame] autorelease];
	[arrow setPointingUp:pointingUp];
	return arrow;
}

- (id) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeTop;
		self.pointingUp = YES;
		self.clipsToBounds = NO;
	}
	return self;
}

- (void) setPointingUp:(BOOL)pointingUp {
	_pointingUp = pointingUp;
	[self setNeedsDisplay];
}

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	/*
	 * We want the touchable area to be quite a bit larger than
	 * the very small arrow itself, so let's test againsts something
	 * larger than the bounds.
	 */
	CGRect touchable = CGRectMake(self.bounds.origin.x-20, self.bounds.origin.y-20, self.bounds.size.width+40, self.bounds.size.height+35);
	return CGRectContainsPoint(touchable, point);
}

- (void) drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat alignStroke;
	CGMutablePathRef path;
	CGPoint point;
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	
	CGContextSaveGState(context);
	
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

////////////////////////////////////////////////////////////

@implementation GNToggleBackground

- (id) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}
	return self;
}

- (void) drawRect:(CGRect)rect {
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
	CGContextClipToRect(context,self.bounds);
	
	// Bar
	
	alignStroke = 0.0;
	path = CGPathCreateMutable();
	point = CGPointMake(2.0, 8.0);
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((self.bounds.size.width/2.0) - 11.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((self.bounds.size.width/2.0) - 11.0, 3.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((self.bounds.size.width/2.0) - 8.0, 0.0);
	controlPoint1 = CGPointMake((self.bounds.size.width/2.0) - 11.0, 1.0);
	controlPoint2 = CGPointMake((self.bounds.size.width/2.0) - 10.0, 0.0);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((self.bounds.size.width/2.0) + 8.0, 0.0);
	controlPoint1 = CGPointMake((self.bounds.size.width/2.0) - 3.0, 0.0);
	controlPoint2 = CGPointMake((self.bounds.size.width/2.0) + 3.0, 0.0);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((self.bounds.size.width/2.0) + 11.0, 3.0);
	controlPoint1 = CGPointMake((self.bounds.size.width/2.0) + 10.0, 0.0);
	controlPoint2 = CGPointMake((self.bounds.size.width/2.0) + 11.0, 1.0);
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((self.bounds.size.width/2.0) + 11.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(self.bounds.size.width + 2.0, 8.0);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(self.bounds.size.width + 2.0, 59.0);
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

@end
