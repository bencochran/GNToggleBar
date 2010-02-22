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

@synthesize quickView=_quickView, tableCell=_tableCell, title=_title,
			image=_image, active=_active;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
	if (self = [super init]) {
		_title = [title copy];
		_image = [image retain];
	}
	return self;
}

- (void)setActive:(BOOL)active {
	_active = active;
	
	[self.quickView setNeedsDisplay];
	[self.tableCell setNeedsDisplay];
}

- (GNQuickToggleItemView *)quickView {
	if (_quickView == nil) {
		self.quickView = [GNQuickToggleItemView viewForItem:self];
	}
	return _quickView;
}

- (GNToggleIcon *)icon {
	return [[[GNToggleIcon alloc] initWithItem:self] autorelease];
}

//- (void)setToggleBar:(GNToggleBar *)toggleBar {
//	_toggleBar = toggleBar;
//}

- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}

@end

////////////////////////////////////////////////////////////

@implementation GNQuickToggleItemView

@synthesize item=_item, icon=_icon, label=_label;

+ (GNQuickToggleItemView *)viewForItem:(GNToggleItem *)item {
	return [[[GNQuickToggleItemView alloc] initWithItem:item] autorelease];
}

- (id)initWithItem:(GNToggleItem *)item {
	if (self = [self init]) {
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;

		self.item = item;
		
		// Set up and add the icon view
//		self.icon = [[GNToggleIcon alloc] initWithImage:image];
		self.icon = self.item.icon;
		self.icon.frame = CGRectMake(0, 2, self.bounds.size.width, 30);
		self.icon.center = CGPointMake(self.bounds.size.width / 2, 15);
		[self addSubview:self.icon];
		
		// Set up and add the label view
		CGRect labelFrame = CGRectMake(0, 31, self.bounds.size.width, 14);
		self.label = [[UILabel alloc] initWithFrame:labelFrame];
		self.label.backgroundColor = [UIColor clearColor];
		self.label.text = self.item.title;
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

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[self.icon setNeedsDisplay];
}

- (void)layoutSubviews {
	// Reposition the icon and label
	self.icon.frame = CGRectMake(0, 2, self.bounds.size.width, 30);
	self.icon.center = CGPointMake(self.bounds.size.width / 2, 15);
	
	CGRect labelFrame = CGRectMake(0, 31, self.bounds.size.width, 14);
	self.label.frame = labelFrame;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	isTouching = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (isTouching) {
		// Simply toggle our active state and redraw
		self.item.active = !self.item.active;
		
		// Send the TouchUpInside and ValueChanged event
		[self sendActionsForControlEvents:UIControlEventTouchUpInside | UIControlEventValueChanged];
		
		isTouching = NO;
	}
}

- (void)dealloc {
	[_label release];
	[_icon release];
	
	[super dealloc];
}

@end

////////////////////////////////////////////////////////////

@implementation GNToggleItemTableViewCell

@synthesize item=_item, icon=_icon, title=_title;

static UIFont *font = nil;

+ (void)initialize
{
	if(self == [GNToggleItemTableViewCell class])
	{
		font = [[UIFont boldSystemFontOfSize:20] retain];
		// this is a good spot to load any graphics you might be drawing in -drawContentView:
		// just load them and retain them here (ONLY if they're small enough that you don't care about them wasting memory)
		// the idea is to do as LITTLE work (e.g. allocations) in -drawContentView: as possible
	}
}

- (void)setItem:(GNToggleItem *)item {
	if (_item != item) {
		_item = item;
		
		self.icon = item.icon;
		self.icon.frame = CGRectMake(4, 6, 30, 30);
		[self addSubview:self.icon];
		
		self.title = item.title;
		[self setNeedsDisplay];
		
		self.item.tableCell = self;
	}
}


- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[self.icon setNeedsDisplay];
}

//- (void)setIcon:(GNToggleIcon *)icon {
//	@synchronized(self) {
//        if (_icon != icon) {
//            [_icon release];
//            _icon = [icon retain];
//			_icon.frame = CGRectMake(0, 0, 30, 30);
//			[self addSubview:self.icon];
//			[self setNeedsDisplay];
//        }
//    }	
//}

//- (void)setTitle:(NSString *)title {
//	[_title release];
//	_title = [title copy];
//	[self setNeedsDisplay];
//}

- (void)drawContentView:(CGRect)r {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *backgroundColor = [UIColor clearColor];
	UIColor *textColor = [UIColor whiteColor];
	
//	if(self.selected)
//	{
//		backgroundColor = [UIColor clearColor];
//		textColor = [UIColor whiteColor];
//	}
	
	[backgroundColor set];
	CGContextFillRect(context, r);
	
	CGPoint p;
	p.x = 40;
	p.y = 9;
	
	[textColor set];
	[_title drawAtPoint:p withFont:font];
}

@end

////////////////////////////////////////////////////////////

@implementation GNToggleIcon

@synthesize item=_item, image=_image;

-(id) initWithItem:(GNToggleItem *)item {
	if (self = [super init]) {
		self.item = item;
		
		self.image = self.item.image;
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;
		//self.item.active = NO;
		
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
	
	if (self.item.active) {
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