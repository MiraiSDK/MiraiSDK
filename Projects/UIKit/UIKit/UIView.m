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

@implementation UIView {
    BOOL _implementsDrawRect;
    NSMutableArray *_subViews;
}

+ (Class)layerClass
{
    return [CALayer class];
}

+ (BOOL)_instanceImplementsDrawRect
{
    return [UIView instanceMethodForSelector:@selector(drawRect:)] != [self instanceMethodForSelector:@selector(drawRect:)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        Class class = object_getClass(self);
        _implementsDrawRect = [[self class] _instanceImplementsDrawRect];
        NSLog(@"is %@ implements drawRect: .... %@",NSStringFromClass([self class]),_implementsDrawRect?@"YES":@"NO");

        _subViews = [NSMutableArray array];
        
        Class layerClass = [class layerClass];
        _layer = [[layerClass alloc] init];
        _layer.delegate = self;
        [_layer setNeedsDisplay];
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

- (void)setNeedsDisplay
{
    
}

- (void)setNeedsDisplayInRect:(CGRect)rect
{
    
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    // For notes about why this is done, see displayLayer: above.
    //
    // with GNU's runtime, compare selector must use sel_isEqual()
    //
    if (sel_isEqual(aSelector, @selector(displayLayer:))) {
        return !_implementsDrawRect;
    } else {
        BOOL responds = [super respondsToSelector:aSelector];
        NSLog(@"%@",responds?@"YES":@"NO");
        return responds;
    }
}

- (void)addSubview:(UIView *)view
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,view);
    [_layer addSublayer:view.layer];
    [_subViews addObject:view];
}

- (void)displayLayer:(CALayer *)theLayer
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextTranslateCTM(ctx, theLayer.frame.origin.x, theLayer.frame.origin.y);
    
    if (theLayer.backgroundColor) {
        CGContextSetFillColorWithColor(ctx, theLayer.backgroundColor);
        CGContextFillRect(ctx, theLayer.frame);
    }
    
    for (UIView *subView in _subViews) {
        NSLog(@"draw layer:%@",subView.layer);
        if (subView.layer.needsDisplay) {
            CGContextSaveGState(ctx);
            [subView.layer displayIfNeeded];
            CGContextRestoreGState(ctx);
            
            if (subView.layer.contents) {
                NSLog(@"draw layer contnts.");
                CGContextDrawImage(ctx, subView.layer.frame, subView.layer.contents);
            }
        }

    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"layer bounds:{%.2f,%.2f,%.2f,%.2f}",layer.bounds.origin.x,layer.bounds.origin.y,layer.bounds.size.width,layer.bounds.size.height);
    // We only get here if the UIView subclass implements drawRect:. To do this without a drawRect: is a huge waste of memory.
    const CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSLog(@"bounds:{%.2f,%.2f,%.2f,%.2f}",bounds.origin.x,bounds.origin.y,bounds.size.width,bounds.size.height);
    UIGraphicsPushContext(ctx);
    CGContextSaveGState(ctx);
    [self drawRect:layer.bounds];
    CGContextRestoreGState(ctx);
    UIGraphicsPopContext();
    
    CGImageRef image = CGBitmapContextCreateImage(ctx);
    layer.contents = image;
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
        NSLog(@"set layer frame: {%.2f,%.2f,%.2f,%.2f}",newFrame.origin.x,newFrame.origin.y,newFrame.size.width,newFrame.size.height);
        _layer.bounds = CGRectMake(0, 0, newFrame.size.width, newFrame.size.height);
        _layer.position = CGPointMake(newFrame.origin.x, newFrame.origin.y);
        
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
