//
//  UIWindow.m
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIWindow.h"
#import "UIScreen.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIWindow
- (id)initWithFrame:(CGRect)theFrame
{
    if ((self=[super initWithFrame:theFrame])) {
        _undoManager = [[NSUndoManager alloc] init];
        [self _makeHidden];	// do this first because before the screen is set, it will prevent any visibility notifications from being sent.
        self.screen = [UIScreen mainScreen];
        self.opaque = NO;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self _makeHidden];	// I don't really like this here, but the real UIKit seems to do something like this on window destruction as it sends a notification and we also need to remove it from the app's list of windows
    
}

- (UIView *)superview
{
    return nil;		// lies!
}

- (void)removeFromSuperview
{
    // does nothing
}

- (UIWindow *)window
{
    return self;
}

- (UIResponder *)nextResponder
{
    return [UIApplication sharedApplication];
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    NS_UNIMPLEMENTED_LOG;
//    if (rootViewController != _rootViewController) {
//        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        [_rootViewController release];
//        _rootViewController = [rootViewController retain];
//        _rootViewController.view.frame = self.bounds;    // unsure about this
//        [self addSubview:_rootViewController.view];
//    }
}


- (void)setScreen:(UIScreen *)theScreen
{
    NS_UNIMPLEMENTED_LOG;
//    if (theScreen != _screen) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenModeDidChangeNotification object:_screen];
//        
//        const BOOL wasHidden = self.hidden;
//        [self _makeHidden];
//        
//        [self.layer removeFromSuperlayer];
//        _screen = theScreen;
//        [[_screen _layer] addSublayer:self.layer];
//        
//        if (!wasHidden) {
//            [self _makeVisible];
//        }
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_screenModeChangedNotification:) name:UIScreenModeDidChangeNotification object:_screen];
//    }
}

- (void)_screenModeChangedNotification:(NSNotification *)note
{
    NS_UNIMPLEMENTED_LOG;
//    UIScreenMode *previousMode = [[note userInfo] objectForKey:@"_previousMode"];
//    UIScreenMode *newMode = _screen.currentMode;
//    
//    if (!CGSizeEqualToSize(previousMode.size,newMode.size)) {
//        [self _superviewSizeDidChangeFrom:previousMode.size to:newMode.size];
//    }
}

- (CGPoint)convertPoint:(CGPoint)toConvert toWindow:(UIWindow *)toWindow
{
    NS_UNIMPLEMENTED_LOG;
    return CGPointZero;
//    if (toWindow == self) {
//        return toConvert;
//    } else {
//        // Convert to screen coordinates
//        toConvert.x += self.frame.origin.x;
//        toConvert.y += self.frame.origin.y;
//        
//        if (toWindow) {
//            // Now convert the screen coords into the other screen's coordinate space
//            toConvert = [self.screen convertPoint:toConvert toScreen:toWindow.screen];
//            
//            // And now convert it from the new screen's space into the window's space
//            toConvert.x -= toWindow.frame.origin.x;
//            toConvert.y -= toWindow.frame.origin.y;
//        }
//        
//        return toConvert;
//    }
}

- (CGPoint)convertPoint:(CGPoint)toConvert fromWindow:(UIWindow *)fromWindow
{
    NS_UNIMPLEMENTED_LOG;
    return CGPointZero;
//    if (fromWindow == self) {
//        return toConvert;
//    } else {
//        if (fromWindow) {
//            // Convert to screen coordinates
//            toConvert.x += fromWindow.frame.origin.x;
//            toConvert.y += fromWindow.frame.origin.y;
//            
//            // Change to this screen.
//            toConvert = [self.screen convertPoint:toConvert fromScreen:fromWindow.screen];
//        }
//        
//        // Convert to window coordinates
//        toConvert.x -= self.frame.origin.x;
//        toConvert.y -= self.frame.origin.y;
//        
//        return toConvert;
//    }
}

- (CGRect)convertRect:(CGRect)toConvert fromWindow:(UIWindow *)fromWindow
{
    CGPoint convertedOrigin = [self convertPoint:toConvert.origin fromWindow:fromWindow];
    return CGRectMake(convertedOrigin.x, convertedOrigin.y, toConvert.size.width, toConvert.size.height);
}

- (CGRect)convertRect:(CGRect)toConvert toWindow:(UIWindow *)toWindow
{
    CGPoint convertedOrigin = [self convertPoint:toConvert.origin toWindow:toWindow];
    return CGRectMake(convertedOrigin.x, convertedOrigin.y, toConvert.size.width, toConvert.size.height);
}

- (void)becomeKeyWindow
{
    NS_UNIMPLEMENTED_LOG;
//    if ([[self _firstResponder] respondsToSelector:@selector(becomeKeyWindow)]) {
//        [(id)[self _firstResponder] becomeKeyWindow];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIWindowDidBecomeKeyNotification object:self];
}

- (void)makeKeyWindow
{
    NS_UNIMPLEMENTED_LOG;
//    if (!self.isKeyWindow) {
//        [[UIApplication sharedApplication].keyWindow resignKeyWindow];
//        [[UIApplication sharedApplication] _setKeyWindow:self];
//        [self becomeKeyWindow];
//    }
}

- (BOOL)isKeyWindow
{
    return ([UIApplication sharedApplication].keyWindow == self);
}

- (void)resignKeyWindow
{
    NS_UNIMPLEMENTED_LOG;
//    if ([[self _firstResponder] respondsToSelector:@selector(resignKeyWindow)]) {
//        [(id)[self _firstResponder] resignKeyWindow];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIWindowDidResignKeyNotification object:self];
}

- (void)_makeHidden
{
//    if (!self.hidden) {
//        [super setHidden:YES];
//        if (self.screen) {
//            [[UIApplication sharedApplication] _windowDidBecomeHidden:self];
//            [[NSNotificationCenter defaultCenter] postNotificationName:UIWindowDidBecomeHiddenNotification object:self];
//        }
//    }
}

- (void)_makeVisible
{
//    if (self.hidden) {
//        [super setHidden:NO];
//        if (self.screen) {
//            [[UIApplication sharedApplication] _windowDidBecomeVisible:self];
//            [[NSNotificationCenter defaultCenter] postNotificationName:UIWindowDidBecomeVisibleNotification object:self];
//        }
//    }
}

- (void)setHidden:(BOOL)hide
{
    if (hide) {
        [self _makeHidden];
    } else {
        [self _makeVisible];
    }
}

- (void)makeKeyAndVisible
{
    [self _makeVisible];
    [self makeKeyWindow];
}

- (void)setWindowLevel:(UIWindowLevel)level
{
    self.layer.zPosition = level;
}

- (UIWindowLevel)windowLevel
{
    return self.layer.zPosition;
}

- (void)sendEvent:(UIEvent *)event
{
    NS_UNIMPLEMENTED_LOG;
}
@end
