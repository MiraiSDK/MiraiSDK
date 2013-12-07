//
//  UIWindow.h
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIView.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIKitDefines.h>

typedef CGFloat UIWindowLevel;

@class UIEvent, UIScreen, NSUndoManager, UIViewController;

@interface UIWindow : UIView

@property(nonatomic,retain) UIScreen *screen;
@property(nonatomic) UIWindowLevel windowLevel;
@property(nonatomic,readonly,getter=isKeyWindow) BOOL keyWindow;

- (void)becomeKeyWindow;
- (void)resignKeyWindow;

- (void)makeKeyWindow;
- (void)makeKeyAndVisible;

@property(nonatomic,retain) UIViewController *rootViewController;

- (void)sendEvent:(UIEvent *)event;

- (CGPoint)convertPoint:(CGPoint)point toWindow:(UIWindow *)window;
- (CGPoint)convertPoint:(CGPoint)point fromWindow:(UIWindow *)window;
- (CGRect)convertRect:(CGRect)rect toWindow:(UIWindow *)window;
- (CGRect)convertRect:(CGRect)rect fromWindow:(UIWindow *)window;

@end

UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal;
UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert;
UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar;

UIKIT_EXTERN NSString *const UIWindowDidBecomeVisibleNotification; // nil
UIKIT_EXTERN NSString *const UIWindowDidBecomeHiddenNotification;  // nil
UIKIT_EXTERN NSString *const UIWindowDidBecomeKeyNotification;     // nil
UIKIT_EXTERN NSString *const UIWindowDidResignKeyNotification;     // nil

UIKIT_EXTERN NSString *const UIKeyboardWillShowNotification;
UIKIT_EXTERN NSString *const UIKeyboardDidShowNotification;
UIKIT_EXTERN NSString *const UIKeyboardWillHideNotification;
UIKIT_EXTERN NSString *const UIKeyboardDidHideNotification;

UIKIT_EXTERN NSString *const UIKeyboardFrameBeginUserInfoKey;
UIKIT_EXTERN NSString *const UIKeyboardFrameEndUserInfoKey;
UIKIT_EXTERN NSString *const UIKeyboardAnimationDurationUserInfoKey;
UIKIT_EXTERN NSString *const UIKeyboardAnimationCurveUserInfoKey;

UIKIT_EXTERN NSString *const UIKeyboardWillChangeFrameNotification;
UIKIT_EXTERN NSString *const UIKeyboardDidChangeFrameNotification;

//DEPRECATED
//UIKIT_EXTERN NSString *const UIKeyboardCenterBeginUserInfoKey   NS_DEPRECATED_IOS(2_0, 3_2);
//UIKIT_EXTERN NSString *const UIKeyboardCenterEndUserInfoKey     NS_DEPRECATED_IOS(2_0, 3_2);
//UIKIT_EXTERN NSString *const UIKeyboardBoundsUserInfoKey        NS_DEPRECATED_IOS(2_0, 3_2);


