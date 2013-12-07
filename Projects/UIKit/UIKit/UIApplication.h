//
//  UIApplication.h
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import "UIResponder.h"
#import "UIKitDefines.h"

@class UIView, UIWindow, UIStatusBar, UIStatusBarWindow, UILocalNotification;
@protocol UIApplicationDelegate;

@interface UIApplication : UIResponder
+ (UIApplication *)sharedApplication;
@property(nonatomic,assign) id<UIApplicationDelegate> delegate;

@property(nonatomic,readonly) UIWindow *keyWindow;
@property(nonatomic,readonly) NSArray  *windows;

@end

@protocol UIApplicationDelegate<NSObject>

@optional

- (void)applicationDidFinishLaunching:(UIApplication *)application;
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@property (nonatomic, retain) UIWindow *window;

@end

UIKIT_EXTERN int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);

UIKIT_EXTERN NSString *const UIApplicationDidFinishLaunchingNotification;
