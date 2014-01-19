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
#import "UIColor.h"
#import "UIGeometry.h"

NSString *const UIViewFrameDidChangeNotification = @"UIViewFrameDidChangeNotification";
NSString *const UIViewBoundsDidChangeNotification = @"UIViewBoundsDidChangeNotification";
NSString *const UIViewDidMoveToSuperviewNotification = @"UIViewDidMoveToSuperviewNotification";
NSString *const UIViewHiddenDidChangeNotification = @"UIViewHiddenDidChangeNotification";

@implementation UIView {
    @package
    BOOL _implementsDrawRect;
    NSMutableSet *_subviews;
    
    UIColor *_backgroundColor;
    UIViewContentMode _contentMode;
    
    BOOL _clearsContextBeforeDrawing;
    BOOL _clipsToBounds;
    
    UIView *_superview;
    UIWindow *_window;
    
    BOOL _autoresizesSubviews;
    
    struct {
        unsigned int userInteractionDisabled:1;
        unsigned int implementsDrawRect:1;
        unsigned int implementsDidScroll:1;
        unsigned int implementsMouseTracking:1;
        unsigned int hasBackgroundColor:1;
        unsigned int isOpaque:1;
        unsigned int becomeFirstResponderWhenCapable:1;
        unsigned int interceptMouseEvent:1;
        unsigned int deallocating:1;
        unsigned int debugFlash:1;
        unsigned int debugSkippedSetNeedsDisplay:1;
        unsigned int debugScheduledDisplayIsRequired:1;
        unsigned int isInAWindow:1;
        unsigned int isAncestorOfFirstResponder:1;
        unsigned int dontAutoresizeSubviews:1;
        unsigned int autoresizeMask:6;
        unsigned int patternBackground:1;
        unsigned int fixedBackgroundPattern:1;
        unsigned int dontAnimate:1;
        unsigned int superLayerIsView:1;
        unsigned int layerKitPatternDrawing:1;
        unsigned int multipleTouchEnabled:1;
        unsigned int exclusiveTouch:1;
        unsigned int hasViewController:1;
        unsigned int needsDidAppearOrDisappear:1;
        unsigned int gesturesEnabled:1;
        unsigned int deliversTouchesForGesturesToSuperview:1;
        unsigned int chargeEnabled:1;
        unsigned int skipsSubviewEnumeration:1;
        unsigned int needsDisplayOnBoundsChange:1;
        unsigned int hasTiledLayer:1;
        unsigned int hasLargeContent:1;
        unsigned int unused:1;
        unsigned int traversalMark:1;
        unsigned int appearanceIsInvalid:1;
        unsigned int monitorsSubtree:1;
        unsigned int hostsAutolayoutEngine:1;
        unsigned int constraintsAreClean:1;
        unsigned int subviewLayoutConstraintsAreClean:1;
        unsigned int intrinsicContentSizeConstraintsAreClean:1;
        unsigned int potentiallyHasDanglyConstraints:1;
        unsigned int doesNotTranslateAutoresizingMaskIntoConstraints:1;
        unsigned int autolayoutIsClean:1;
        unsigned int subviewsAutolayoutIsClean:1;
        unsigned int layoutFlushingDisabled:1;
        unsigned int layingOutFromConstraints:1;
        unsigned int wantsAutolayout:1;
        unsigned int subviewWantsAutolayout:1;
        unsigned int isApplyingValuesFromEngine:1;
        unsigned int isInAutolayout:1;
        unsigned int isUpdatingAutoresizingConstraints:1;
        unsigned int isUpdatingConstraints:1;
        unsigned int stayHiddenAwaitingReuse:1;
        unsigned int stayHiddenAfterReuse:1;
        unsigned int skippedLayoutWhileHiddenForReuse:1;
        unsigned int hasMaskView:1;
        unsigned int hasVisualAltitude:1;
        unsigned int hasBackdropMaskViews:1;
        unsigned int backdropMaskViewFlags:3;
        unsigned int delaysTouchesForSystemGestures:1;
        unsigned int subclassShouldDelayTouchForSystemGestures:1;
        unsigned int hasMotionEffects:1;
        unsigned int backdropOverlayMode:2;
        unsigned int tintAdjustmentMode:2;
        unsigned int isReferenceView:1;
    } _viewFlags;
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
        _clearsContextBeforeDrawing = YES;
        _autoresizesSubviews = YES;

        _subviews = [NSMutableSet set];
        
        _layer = [[[class layerClass] alloc] init];
        _layer.delegate = self;
//        _layer.layoutManager = ???
        
        self.contentMode = UIViewContentModeScaleToFill;
        self.contentScaleFactor = 0;
        
        self.frame = frame;
        self.alpha = 1;
        self.opaque = YES;
        
        [self setNeedsDisplay];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc
{
    [[_subviews allObjects] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_layer removeFromSuperlayer];
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

- (BOOL)isUserInteractionEnabled
{
    return  !_viewFlags.userInteractionDisabled;
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    _viewFlags.userInteractionDisabled = !userInteractionEnabled;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; frame = %@; hidden = %@; layer = %@>", [self className], self, NSStringFromCGRect(self.frame), (self.hidden ? @"YES" : @"NO"), self.layer];
}

@end

@implementation UIView (UIViewGeometry)

- (void)setAutoresizingMask:(UIViewAutoresizing)autoresizingMask
{
    _viewFlags.autoresizeMask = autoresizingMask;
}

- (UIViewAutoresizing)autoresizingMask
{
    return _viewFlags.autoresizeMask;
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

- (void)setBounds:(CGRect)aBounds
{
    if (!CGRectEqualToRect(aBounds,_layer.bounds)) {
        CGRect oldBounds = _layer.bounds;
        _layer.bounds = aBounds;
//        [self _boundsDidChangeFrom:oldBounds to:newBounds];
//        [[NSNotificationCenter defaultCenter] postNotificationName:UIViewBoundsDidChangeNotification object:self];
    }
}

- (CGPoint)center
{
    return _layer.position;
}

- (void)setCenter:(CGPoint)aCenter
{
    _layer.position = aCenter;
}

- (CGAffineTransform)transform
{
    return _layer.affineTransform;
}

- (void)setTransform:(CGAffineTransform)aTransform
{
    _layer.affineTransform = aTransform;
}

- (BOOL)isMultipleTouchEnabled
{
    return _viewFlags.multipleTouchEnabled;
}

- (void)setMultipleTouchEnabled:(BOOL)flag
{
    _viewFlags.multipleTouchEnabled = flag;
}
- (BOOL)isExclusiveTouch
{
    return _viewFlags.exclusiveTouch;
}

- (void)setExclusiveTouch:(BOOL)flag
{
    _viewFlags.exclusiveTouch = flag;
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

- (void)setContentScaleFactor:(CGFloat)contentScaleFactor
{
    NSLog(@"Unimplementd Method: %s",__PRETTY_FUNCTION__);
}

- (CGFloat)contentScaleFactor
{
    NSLog(@"Unimplementd Method: %s",__PRETTY_FUNCTION__);
    return 0.0f;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden || !self.userInteractionEnabled || self.alpha < 0.01 || ![self pointInside:point withEvent:event]) {
        return nil;
    } else {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            UIView *hitView = [subview hitTest:[subview convertPoint:point fromView:self] withEvent:event];
            if (hitView) {
                return hitView;
            }
        }
        return self;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return CGRectContainsPoint(self.bounds, point);
}

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view
{
    
    return CGPointZero;
}

- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view
{
    
    return CGPointZero;
}

- (CGRect)convertRect:(CGRect)toConvert fromView:(UIView *)fromView
{
    CGPoint origin = [self convertPoint:CGPointMake(CGRectGetMinX(toConvert),CGRectGetMinY(toConvert)) fromView:fromView];
    CGPoint bottom = [self convertPoint:CGPointMake(CGRectGetMaxX(toConvert),CGRectGetMaxY(toConvert)) fromView:fromView];
    return CGRectMake(origin.x, origin.y, bottom.x-origin.x, bottom.y-origin.y);
}

- (CGRect)convertRect:(CGRect)toConvert toView:(UIView *)toView
{
    CGPoint origin = [self convertPoint:CGPointMake(CGRectGetMinX(toConvert),CGRectGetMinY(toConvert)) toView:toView];
    CGPoint bottom = [self convertPoint:CGPointMake(CGRectGetMaxX(toConvert),CGRectGetMaxY(toConvert)) toView:toView];
    return CGRectMake(origin.x, origin.y, bottom.x-origin.x, bottom.y-origin.y);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return size;
}

- (void)sizeToFit
{
    CGRect frame = self.frame;
    frame.size = [self sizeThatFits:frame.size];
    self.frame = frame;
}

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
    NSArray *sublayers = _layer.sublayers;
    NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:[sublayers count]];
    
    // This builds the results from the layer instead of just using _subviews because I want the results to match
    // the order that CALayer has them. It's unclear in the docs if the returned order from this method is guarenteed or not,
    // however several other aspects of the system (namely the hit testing) depends on this order being correct.
    for (CALayer *layer in sublayers) {
        id potentialView = [layer delegate];
        if ([_subviews containsObject:potentialView]) {
            [subviews addObject:potentialView];
        }
    }
    
    return subviews;
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
    [self addSubview:view];
    [_layer insertSublayer:view.layer atIndex:index];
}

- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2
{
    
} //exchangeSubviewAtIndex:withSubviewAtIndex:

- (void)addSubview:(UIView *)subview
{
    NSAssert((!subview || [subview isKindOfClass:[UIView class]]), @"the subview must be a UIView");

    if (subview && subview.superview != self) {
        UIWindow *oldWindow = subview.window;
        UIWindow *newWindow = self.window;
        
//        subview->_needsDidAppearOrDisappear = [self _subviewControllersNeedAppearAndDisappear];
        
//        if ([subview _viewController] && subview->_needsDidAppearOrDisappear) {
//            [[subview _viewController] viewWillAppear:NO];
//        }
        
//        [subview _willMoveFromWindow:oldWindow toWindow:newWindow];
//        [subview willMoveToSuperview:self];
        
        {
            if (subview.superview) {
                [subview.layer removeFromSuperlayer];
                [subview.superview->_subviews removeObject:subview];
            }
            
            [subview willChangeValueForKey:@"superview"];
            [_subviews addObject:subview];
            subview->_superview = self;
            [_layer addSublayer:subview.layer];
            [subview didChangeValueForKey:@"superview"];
        }
        
//        if (oldWindow.screen != newWindow.screen) {
//            [subview _didMoveToScreen];
//        }
        
//        [subview _didMoveFromWindow:oldWindow toWindow:newWindow];
//        [subview didMoveToSuperview];
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:UIViewDidMoveToSuperviewNotification object:subview];
        
        [self didAddSubview:subview];
        
//        if ([subview _viewController] && subview->_needsDidAppearOrDisappear) {
//            [[subview _viewController] viewDidAppear:NO];
//        }
    }
}

- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [self addSubview:view];
    [_layer insertSublayer:view.layer below:siblingSubview.layer];
}

- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [self addSubview:view];
    [_layer insertSublayer:view.layer above:siblingSubview.layer];
}

- (void)bringSubviewToFront:(UIView *)view
{
    if (view.superview == self) {
        [_layer insertSublayer:view.layer above:[[_layer sublayers] lastObject]];
    }
}

- (void)sendSubviewToBack:(UIView *)view
{
    if (view.superview == self) {
        [_layer insertSublayer:view.layer atIndex:0];
    }
}

- (BOOL)isDescendantOfView:(UIView *)view
{
    if (view) {
        UIView *testView = self;
        while (testView) {
            if (testView == view) {
                return YES;
            } else {
                testView = testView.superview;
            }
        }
    }
    return NO;
}

- (UIView *)viewWithTag:(NSInteger)tag
{
    UIView *foundView = nil;
    
    if (self.tag == tag) {
        foundView = self;
    } else {
        for (UIView *view in [self.subviews reverseObjectEnumerator]) {
            foundView = [view viewWithTag:tag];
            if (foundView)
                break;
        }
    }
    
    return foundView;
}

- (void)setNeedsLayout
{
    [_layer setNeedsLayout];
}

- (void)layoutIfNeeded
{
    [_layer layoutIfNeeded];
}

- (void)_layoutSubviews
{
//    [self _updateAppearanceIfNeeded];
//    [[self _viewController] viewWillLayoutSubviews];
    [self layoutSubviews];
//    [[self _viewController] viewDidLayoutSubviews];
}

#pragma mark Overriding point
- (void)layoutSubviews
{
}

- (void)didAddSubview:(UIView *)subview
{
}

- (void)willRemoveSubview:(UIView *)subview
{
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
}

- (void)didMoveToSuperview
{
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
}

- (void)didMoveToWindow
{
}
@end

@implementation UIView (UIViewRendering)

- (void)setContentMode:(UIViewContentMode)mode
{
    if (mode != _contentMode) {
        _contentMode = mode;
        switch(_contentMode) {
            case UIViewContentModeScaleToFill:
                _layer.contentsGravity = kCAGravityResize;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeScaleAspectFit:
                _layer.contentsGravity = kCAGravityResizeAspect;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeScaleAspectFill:
                _layer.contentsGravity = kCAGravityResizeAspectFill;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeRedraw:
                _layer.needsDisplayOnBoundsChange = YES;
                break;
                
            case UIViewContentModeCenter:
                _layer.contentsGravity = kCAGravityCenter;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeTop:
                _layer.contentsGravity = kCAGravityTop;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeBottom:
                _layer.contentsGravity = kCAGravityBottom;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeLeft:
                _layer.contentsGravity = kCAGravityLeft;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeRight:
                _layer.contentsGravity = kCAGravityRight;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeTopLeft:
                _layer.contentsGravity = kCAGravityTopLeft;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeTopRight:
                _layer.contentsGravity = kCAGravityTopRight;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeBottomLeft:
                _layer.contentsGravity = kCAGravityBottomLeft;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
                
            case UIViewContentModeBottomRight:
                _layer.contentsGravity = kCAGravityBottomRight;
                _layer.needsDisplayOnBoundsChange = NO;
                break;
        }
    }
}


- (UIViewContentMode)contentMode
{
    return _contentMode;
}

- (void)setContentStretch:(CGRect)contentStretch
{
    
}


- (CGRect)contentStretch
{
    return CGRectZero;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor
{
    return _backgroundColor;
}

- (void)displayLayer:(CALayer *)theLayer
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(ctx, theLayer.frame.origin.x, theLayer.frame.origin.y);
    
    if (theLayer.backgroundColor) {
        CGContextSetFillColorWithColor(ctx, theLayer.backgroundColor);
        CGContextFillRect(ctx, theLayer.frame);
    }
    
    for (UIView *subView in _subviews) {
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
    [_layer setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)rect
{
    [_layer setNeedsDisplayInRect:rect];
}

- (BOOL)clipsToBounds
{
    return _layer.masksToBounds;
}

- (void)setClipsToBounds:(BOOL)flag
{
    _layer.masksToBounds = flag;
}

- (CGFloat)alpha
{
    return _layer.opacity;
}

- (void)setAlpha:(CGFloat)anAlpha
{
    _layer.opacity = anAlpha;
}

- (BOOL)isOpaque
{
    return _layer.opaque;
}

- (void)setOpaque:(BOOL)flag
{
    _layer.opaque = flag;
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
    return _layer.hidden;
}

- (void)setHidden:(BOOL)flag
{
    _layer.hidden = flag;
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIViewHiddenDidChangeNotification object:self];
}

#pragma mark iOS 7
- (void)setTintAdjustmentMode:(UIViewTintAdjustmentMode)tintAdjustmentMode
{
    
}

- (UIViewTintAdjustmentMode)tintAdjustmentMode
{
    return UIViewTintAdjustmentModeAutomatic;
}

- (void)setTintColor:(UIColor *)tintColor
{
    
}

- (UIColor *)tintColor
{
    return nil;
}

- (void)tintColorDidChange
{
    
}

@end

@implementation UIView (UIViewAnimation)
static NSMutableArray *_animationGroups;
static BOOL _animationsEnabled = YES;

+ (void)initialize
{
    if (self == [UIView class]) {
        _animationGroups = [[NSMutableArray alloc] init];
    }
}

+ (void)beginAnimations:(NSString *)animationID context:(void *)context
{

}

+ (void)commitAnimations
{
    
}

+ (void)setAnimationDelegate:(id)delegate
{
    
}

+ (void)setAnimationWillStartSelector:(SEL)selector
{
    
}

+ (void)setAnimationDidStopSelector:(SEL)selector
{
    
}

+ (void)setAnimationDuration:(NSTimeInterval)duration
{
    
}

+ (void)setAnimationDelay:(NSTimeInterval)delay
{
    
}

+ (void)setAnimationStartDate:(NSDate *)startDate
{
    
}

+ (void)setAnimationCurve:(UIViewAnimationCurve)curve
{
    
}

+ (void)setAnimationRepeatCount:(float)repeatCount
{
    
}

+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses
{
    
}
+ (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState
{
    
}

+ (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache
{
    
}

+ (void)setAnimationsEnabled:(BOOL)enabled
{
    _animationsEnabled = enabled;
}

+ (BOOL)areAnimationsEnabled
{
    return _animationsEnabled;
}

+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation
{
    
}
@end

@implementation UIView (UIViewAnimationWithBlocks)
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations
{
    
}

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}

+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}

+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion
{
    
}

+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray *)views options:(UIViewAnimationOptions)options animations:(void (^)(void))parallelAnimations completion:(void (^)(BOOL finished))completion
{
    
}
@end

@implementation UIView (UIViewKeyframeAnimations)

+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}

+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations
{
    
}

@end

@implementation UIView (UIViewGestureRecognizers)

- (void)setGestureRecognizers:(NSArray *)gestureRecognizers
{
    
}

- (NSArray *)gestureRecognizers
{
    return nil;
}

- (void)addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    
}

- (void)removeGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

@end



