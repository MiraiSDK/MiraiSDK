//
//  UIView.m
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIView.h"
#import <QuartzCore/CALayer.h>
#import "UIGraphics.h"

@implementation UIView

+ (Class)layerClass
{
    return [CALayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        Class class = object_getClass(self);
        
        Class layerClass = [class layerClass];
        _layer = [[layerClass alloc] init];
        _layer.delegate = self;
//        _layer.layoutManager
        
        self.frame = frame;
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)drawRect:(CGRect)rect
{
}

- (void)displayLayer:(CALayer *)theLayer
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (theLayer.backgroundColor) {
        CGContextSetFillColorWithColor(ctx, theLayer.backgroundColor);
        CGContextFillRect(ctx, theLayer.frame);
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    // We only get here if the UIView subclass implements drawRect:. To do this without a drawRect: is a huge waste of memory.
}

- (CGRect)frame
{
    return _layer.frame;
}

- (void)setFrame:(CGRect)newFrame
{
    if (!CGRectEqualToRect(newFrame,_layer.frame)) {
        CGRect oldBounds = _layer.bounds;
        _layer.frame = newFrame;
//        [self _boundsDidChangeFrom:oldBounds to:_layer.bounds];
//        [[NSNotificationCenter defaultCenter] postNotificationName:UIViewFrameDidChangeNotification object:self];
    }
}

- (CGRect)bounds
{
    return _layer.bounds;
}

- (CGPoint)center
{
    return _layer.position;
}

- (CGAffineTransform)transform
{
    return _layer.affineTransform;
}
@end
