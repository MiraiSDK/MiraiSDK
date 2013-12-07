//
//  UIScreen.m
//  UIKit
//
//  Created by Chen Yonghui on 12/7/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIScreen.h"
#import "UIScreenPrivate.h"

#import "android_native_app_glue.h"
#import <android/native_activity.h>

static NSMutableArray *screens;
@implementation UIScreen {
    id _display;
    CGRect _bounds;
    CGRect _applicationFrame;
    CGFloat _scale;
    
}

+ (void)initialize
{
    screens = [NSMutableArray array];
}

static UIScreen *_mainScreen = nil;
- (instancetype)initWithAndroidNativeWindow:(ANativeWindow *)window
{
    self = [super init];
    if (self) {
        _display = (__bridge_transfer id)(window);
        
        
        //
        // NEEDFIX:
        // Can't access ANativeWindow before ALoop calls
        //
        _bounds = CGRectZero;
//        _bounds = CGRectMake(0,
//                             0,
//                             ANativeWindow_getWidth(window),
//                             ANativeWindow_getHeight(window));

        _applicationFrame = _bounds;
        
        NSLog(@"assign mainscreen");
        _mainScreen = self;
        NSLog(@"add screen");
        [screens addObject:self];
    }
    return self;
}

+ (NSArray *)screens
{
    return screens;
}

+ (UIScreen *)mainScreen
{
    return _mainScreen;
}



- (CGRect)bounds
{
    return _bounds;
}

- (CGRect)applicationFrame
{
    return _applicationFrame;
}

- (CGFloat)scale
{
    return _scale;
}


@end
