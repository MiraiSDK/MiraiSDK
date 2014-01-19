//
//  UIDevice.h
//  UIKit
//
//  Created by Chen Yonghui on 1/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>

typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
    UIDeviceOrientationUnknown,
    UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
    UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
    UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
    UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
    UIDeviceOrientationFaceUp,              // Device oriented flat, face up
    UIDeviceOrientationFaceDown             // Device oriented flat, face down
};

typedef NS_ENUM(NSInteger, UIDeviceBatteryState) {
    UIDeviceBatteryStateUnknown,
    UIDeviceBatteryStateUnplugged,   // on battery, discharging
    UIDeviceBatteryStateCharging,    // plugged in, less than 100%
    UIDeviceBatteryStateFull,        // plugged in, at 100%
};              // available in iPhone 3.0

typedef NS_ENUM(NSInteger, UIUserInterfaceIdiom) {
    UIUserInterfaceIdiomPhone,           // iPhone and iPod touch style UI
    UIUserInterfaceIdiomPad,             // iPad style UI
};

#define UI_USER_INTERFACE_IDIOM() ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] ? [[UIDevice currentDevice] userInterfaceIdiom] : UIUserInterfaceIdiomPhone)

#define UIDeviceOrientationIsPortrait(orientation)  ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown)
#define UIDeviceOrientationIsLandscape(orientation) ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)

@interface UIDevice : NSObject
+ (UIDevice *)currentDevice;

@property(nonatomic,readonly,retain) NSString    *name;              // e.g. "My iPhone"
@property(nonatomic,readonly,retain) NSString    *model;             // e.g. @"iPhone", @"iPod touch"
@property(nonatomic,readonly,retain) NSString    *localizedModel;    // localized version of model
@property(nonatomic,readonly,retain) NSString    *systemName;        // e.g. @"iOS"
@property(nonatomic,readonly,retain) NSString    *systemVersion;     // e.g. @"4.0"
@property(nonatomic,readonly) UIDeviceOrientation orientation;       // return current device orientation.  this will return UIDeviceOrientationUnknown unless device orientation notifications are being generated.

//@property(nonatomic,readonly,retain) NSUUID      *identifierForVendor; NS_AVAILABLE_IOS(6_0);

@property(nonatomic,readonly,getter=isGeneratingDeviceOrientationNotifications) BOOL generatesDeviceOrientationNotifications;
- (void)beginGeneratingDeviceOrientationNotifications;      // nestable
- (void)endGeneratingDeviceOrientationNotifications;

@property(nonatomic,getter=isBatteryMonitoringEnabled) BOOL batteryMonitoringEnabled;
@property(nonatomic,readonly) UIDeviceBatteryState          batteryState;
@property(nonatomic,readonly) float                         batteryLevel;

@property(nonatomic,getter=isProximityMonitoringEnabled) BOOL proximityMonitoringEnabled;
@property(nonatomic,readonly)                            BOOL proximityState;

@property(nonatomic,readonly,getter=isMultitaskingSupported) BOOL multitaskingSupported;
@property(nonatomic,readonly) UIUserInterfaceIdiom userInterfaceIdiom;

- (void)playInputClick;

@end

@protocol UIInputViewAudioFeedback <NSObject>
@optional

@property (nonatomic, readonly) BOOL enableInputClicksWhenVisible; // If YES, an input view will enable playInputClick.

@end

UIKIT_EXTERN NSString *const UIDeviceOrientationDidChangeNotification;
UIKIT_EXTERN NSString *const UIDeviceBatteryStateDidChangeNotification;
UIKIT_EXTERN NSString *const UIDeviceBatteryLevelDidChangeNotification;
UIKIT_EXTERN NSString *const UIDeviceProximityStateDidChangeNotification;
