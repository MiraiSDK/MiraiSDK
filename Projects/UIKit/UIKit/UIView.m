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
    
    BOOL _opaque;
    BOOL _hidden;
    BOOL _alpha;
    BOOL _clearsContextBeforeDrawing;
    BOOL _clipsToBounds;
    
    UIView *_superview;
    NSArray *_subviews;
    UIWindow *_window;
    
    BOOL _multipleTouchEnabled;
    BOOL _exclusiveTouch;
    BOOL _autoresizesSubviews;
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

@end

@implementation UIView (UIViewGeometry)

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

- (void)setBounds:(CGRect)aBounds
{
    _layer.bounds = aBounds;
}

- (void)setCenter:(CGPoint)aCenter
{
    _layer.position = aCenter;
}

- (void)setTransform:(CGAffineTransform)aTransform
{
    _layer.affineTransform = aTransform;
}

- (BOOL)isMultipleTouchEnabled
{
    return _multipleTouchEnabled;
}

- (void)setMultipleTouchEnabled:(BOOL)flag
{
    if (_multipleTouchEnabled != flag) {
        _multipleTouchEnabled = flag;
    }
}
- (BOOL)isExclusiveTouch
{
    return _exclusiveTouch;
}

- (void)setExclusiveTouch:(BOOL)flag
{
    if (_exclusiveTouch != flag) {
        _exclusiveTouch = flag;
    }
}
- (BOOL)autoresizesSubviews
{
    return _autoresizesSubviews;
}

- (void)setAutoresizesSubviews:(BOOL)flag
{
    if (_autoresizesSubviews != flag) {
        _autoresizesSubviews = flag;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    return nil;
} //hitTest:withEvent:

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    return NO;
} //pointInside:withEvent:

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view
{
    
    return CGPointZero;
} //convertPoint:toView:

- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view
{
    
    return CGPointZero;
} //convertPoint:fromView:

- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view
{
    return CGRectZero;
} //convertRect:toView:

- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view
{
    
    return CGRectZero;
} //convertRect:fromView:


- (CGSize)sizeThatFits:(CGSize)size
{
    
    return CGSizeZero;
} //sizeThatFits:

- (void)sizeToFit
{
    
} //sizeToFit

@end

@implementation UIView (UIViewHierarchy)
- (UIView *)superview
{
    return _superview;
}

- (void)setSuperview:(UIView *)aSuperview
{
    if (_superview != aSuperview) {
        _superview = aSuperview;
    }
}
- (NSArray *)subviews
{
    return _subviews;
}

- (void)setSubviews:(NSArray *)aSubviews
{
    if (_subviews != aSubviews) {
        _subviews = aSubviews;
    }
}
- (UIWindow *)window
{
    return _window;
}

- (void)setWindow:(UIWindow *)aWindow
{
    if (_window != aWindow) {
        _window = aWindow;
    }
}

- (void)removeFromSuperview
{
    
} //removeFromSuperview

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    
} //insertSubview:atIndex:

- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2
{
    
} //exchangeSubviewAtIndex:withSubviewAtIndex:

- (void)addSubview:(UIView *)view
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,view);
    [_layer addSublayer:view.layer];
    [_subViews addObject:view];
}

- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    
} //insertSubview:belowSubview:

- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    
} //insertSubview:aboveSubview:

- (void)bringSubviewToFront:(UIView *)view
{
    
} //bringSubviewToFront:

- (void)sendSubviewToBack:(UIView *)view
{
    
} //sendSubviewToBack:

- (void)didAddSubview:(UIView *)subview
{
    
} //didAddSubview:

- (void)willRemoveSubview:(UIView *)subview
{
    
} //willRemoveSubview:

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    
} //willMoveToSuperview:

- (void)didMoveToSuperview
{
    
} //didMoveToSuperview

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    
} //willMoveToWindow:

- (void)didMoveToWindow
{
    
} //didMoveToWindow

- (BOOL)isDescendantOfView:(UIView *)view
{
    
    return NO;
} //isDescendantOfView:

- (UIView *)viewWithTag:(NSInteger)tag
{
    
    return nil;
} //viewWithTag:

- (void)setNeedsLayout
{
    
} //setNeedsLayout

- (void)layoutIfNeeded
{
    
} //layoutIfNeeded

- (void)layoutSubviews
{
    
} //layoutSubviews


@end

@implementation UIView (UIViewRendering)

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

- (void)drawRect:(CGRect)rect
{
    
}

- (void)setNeedsDisplay
{
    
}
- (void)setNeedsDisplayInRect:(CGRect)rect
{
    
}


- (BOOL)clipsToBounds
{
    return _clipsToBounds;
}

- (void)setClipsToBounds:(BOOL)flag
{
    if (_clipsToBounds != flag) {
        _clipsToBounds = flag;
    }
}
- (CGFloat)alpha
{
    return _alpha;
}

- (void)setAlpha:(CGFloat)anAlpha
{
    if (_alpha != anAlpha) {
        _alpha = anAlpha;
    }
}
- (BOOL)isOpaque
{
    return _opaque;
}

- (void)setOpaque:(BOOL)flag
{
    if (_opaque != flag) {
        _opaque = flag;
    }
}
- (BOOL)clearsContextBeforeDrawing
{
    return _clearsContextBeforeDrawing;
}

- (void)setClearsContextBeforeDrawing:(BOOL)flag
{
    if (_clearsContextBeforeDrawing != flag) {
        _clearsContextBeforeDrawing = flag;
    }
}
- (BOOL)isHidden
{
    return _hidden;
}

- (void)setHidden:(BOOL)flag
{
    if (_hidden != flag) {
        _hidden = flag;
    }
}

@end


