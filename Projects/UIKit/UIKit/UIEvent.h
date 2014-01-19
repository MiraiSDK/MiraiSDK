//
//  UIEvent.h
//  UIKit
//
//  Created by Chen Yonghui on 1/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

@class UIWindow, UIView, UIGestureRecognizer;

typedef NS_ENUM(NSInteger, UIEventType) {
    UIEventTypeTouches,
    UIEventTypeMotion,
    UIEventTypeRemoteControl,
};

typedef NS_ENUM(NSInteger, UIEventSubtype) {
    // available in iPhone OS 3.0
    UIEventSubtypeNone                              = 0,
    
    // for UIEventTypeMotion, available in iPhone OS 3.0
    UIEventSubtypeMotionShake                       = 1,
    
    // for UIEventTypeRemoteControl, available in iOS 4.0
    UIEventSubtypeRemoteControlPlay                 = 100,
    UIEventSubtypeRemoteControlPause                = 101,
    UIEventSubtypeRemoteControlStop                 = 102,
    UIEventSubtypeRemoteControlTogglePlayPause      = 103,
    UIEventSubtypeRemoteControlNextTrack            = 104,
    UIEventSubtypeRemoteControlPreviousTrack        = 105,
    UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
    UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
    UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
    UIEventSubtypeRemoteControlEndSeekingForward    = 109,
};

@interface UIEvent : NSObject
@property(nonatomic,readonly) UIEventType     type;// NS_AVAILABLE_IOS(3_0);
@property(nonatomic,readonly) UIEventSubtype  subtype;// NS_AVAILABLE_IOS(3_0);

@property(nonatomic,readonly) NSTimeInterval  timestamp;

- (NSSet *)allTouches;
- (NSSet *)touchesForWindow:(UIWindow *)window;
- (NSSet *)touchesForView:(UIView *)view;
- (NSSet *)touchesForGestureRecognizer:(UIGestureRecognizer *)gesture;// NS_AVAILABLE_IOS(3_2);

@end
