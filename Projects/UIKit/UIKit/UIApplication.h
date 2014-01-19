//
//  UIApplication.h
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import <UIKit/UIKitDefines.h>
#import <UIKit/UIResponder.h>
//#import <UIKit/UIInterface.h>
#import <UIKit/UIDevice.h>
//#import <UIKit/UIAlert.h>

#import <UIKit/UIView.h>

typedef NS_ENUM(NSInteger, UIStatusBarStyle) {
    UIStatusBarStyleDefault             = 0, // Dark content, for use on light backgrounds
    UIStatusBarStyleLightContent        = 1, // Light content, for use on dark backgrounds
    
    UIStatusBarStyleBlackTranslucent    = 1,
    UIStatusBarStyleBlackOpaque         = 2,
};

typedef NS_ENUM(NSInteger, UIStatusBarAnimation) {
    UIStatusBarAnimationNone,
    UIStatusBarAnimationFade,
    UIStatusBarAnimationSlide,
};

typedef NS_ENUM(NSInteger, UIInterfaceOrientation) {
    UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
    UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
    UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
    UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
};

UIKIT_EXTERN NSString *const UIApplicationInvalidInterfaceOrientationException;

typedef NS_OPTIONS(NSUInteger, UIInterfaceOrientationMask) {
    UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
    UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
    UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
    UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
    UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
    UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
    UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
};

#define UIDeviceOrientationIsValidInterfaceOrientation(orientation) ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown || (orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)
#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

typedef NS_OPTIONS(NSUInteger, UIRemoteNotificationType) {
    UIRemoteNotificationTypeNone    = 0,
    UIRemoteNotificationTypeBadge   = 1 << 0,
    UIRemoteNotificationTypeSound   = 1 << 1,
    UIRemoteNotificationTypeAlert   = 1 << 2,
    UIRemoteNotificationTypeNewsstandContentAvailability = 1 << 3,
};

typedef NS_ENUM(NSUInteger, UIBackgroundFetchResult) {
    UIBackgroundFetchResultNewData,
    UIBackgroundFetchResultNoData,
    UIBackgroundFetchResultFailed
};

typedef NS_ENUM(NSInteger, UIBackgroundRefreshStatus) {
    UIBackgroundRefreshStatusRestricted, //< unavailable on this system due to device configuration; the user cannot enable the feature
    UIBackgroundRefreshStatusDenied,     //< explicitly disabled by the user for this application
    UIBackgroundRefreshStatusAvailable   //< enabled for this application
};

typedef NS_ENUM(NSInteger, UIApplicationState) {
    UIApplicationStateActive,
    UIApplicationStateInactive,
    UIApplicationStateBackground
};

typedef NSUInteger UIBackgroundTaskIdentifier;
UIKIT_EXTERN const UIBackgroundTaskIdentifier UIBackgroundTaskInvalid;
UIKIT_EXTERN const NSTimeInterval UIMinimumKeepAliveTimeout;
UIKIT_EXTERN const NSTimeInterval UIApplicationBackgroundFetchIntervalMinimum;
UIKIT_EXTERN const NSTimeInterval UIApplicationBackgroundFetchIntervalNever;

typedef NS_ENUM(NSInteger, UIUserInterfaceLayoutDirection) {
    UIUserInterfaceLayoutDirectionLeftToRight,
    UIUserInterfaceLayoutDirectionRightToLeft,
};

@class UIView, UIWindow, UIStatusBar, UIStatusBarWindow, UILocalNotification;
@protocol UIApplicationDelegate;

@interface UIApplication : UIResponder //FIXME: <UIActionSheetDelegate>

+ (UIApplication *)sharedApplication;
@property(nonatomic,assign) id<UIApplicationDelegate> delegate;

- (void)beginIgnoringInteractionEvents;
- (void)endIgnoringInteractionEvents;
- (BOOL)isIgnoringInteractionEvents;

@property(nonatomic,getter=isIdleTimerDisabled)       BOOL idleTimerDisabled;

- (BOOL)openURL:(NSURL*)url;
- (BOOL)canOpenURL:(NSURL *)url;

- (void)sendEvent:(UIEvent *)event;

@property(nonatomic,readonly) UIWindow *keyWindow;
@property(nonatomic,readonly) NSArray  *windows;

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event;

@property(nonatomic,getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;

@property(nonatomic) UIStatusBarStyle statusBarStyle;
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated;

@property(nonatomic,getter=isStatusBarHidden) BOOL statusBarHidden;
- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation;

@property(nonatomic) UIInterfaceOrientation statusBarOrientation;
- (void)setStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation animated:(BOOL)animated;

- (NSUInteger)supportedInterfaceOrientationsForWindow:(UIWindow *)window;

@property(nonatomic,readonly) NSTimeInterval statusBarOrientationAnimationDuration;
@property(nonatomic,readonly) CGRect statusBarFrame;

@property(nonatomic) NSInteger applicationIconBadgeNumber;

@property(nonatomic) BOOL applicationSupportsShakeToEdit;

@property(nonatomic,readonly) UIApplicationState applicationState;
@property(nonatomic,readonly) NSTimeInterval backgroundTimeRemaining;

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void(^)(void))handler;
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)taskName expirationHandler:(void(^)(void))handler;
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier;

- (void)setMinimumBackgroundFetchInterval:(NSTimeInterval)minimumBackgroundFetchInterval;

@property (nonatomic, readonly) UIBackgroundRefreshStatus backgroundRefreshStatus;

- (BOOL)setKeepAliveTimeout:(NSTimeInterval)timeout handler:(void(^)(void))keepAliveHandler;
- (void)clearKeepAliveTimeout;

@property(nonatomic,readonly,getter=isProtectedDataAvailable) BOOL protectedDataAvailable;

@property(nonatomic,readonly) UIUserInterfaceLayoutDirection userInterfaceLayoutDirection;

@property(nonatomic,readonly) NSString *preferredContentSizeCategory;

@end

@interface UIApplication (UIRemoteNotifications)

- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types;
- (void)unregisterForRemoteNotifications;

- (UIRemoteNotificationType)enabledRemoteNotificationTypes;

@end

@interface UIApplication (UILocalNotifications)

- (void)presentLocalNotificationNow:(UILocalNotification *)notification;

- (void)scheduleLocalNotification:(UILocalNotification *)notification;
- (void)cancelLocalNotification:(UILocalNotification *)notification;
- (void)cancelAllLocalNotifications;
@property(nonatomic,copy) NSArray *scheduledLocalNotifications;

@end

@interface UIApplication (UIRemoteControlEvents)

- (void)beginReceivingRemoteControlEvents;
- (void)endReceivingRemoteControlEvents;

@end

//@interface UIApplication (UINewsstand)
//- (void)setNewsstandIconImage:(UIImage *)image;
//@end

@protocol UIStateRestoring;
@interface UIApplication (UIStateRestoration)
- (void)extendStateRestoration;
- (void)completeStateRestoration;

- (void)ignoreSnapshotOnNextApplicationLaunch;

+ (void) registerObjectForStateRestoration:(id<UIStateRestoring>)object restorationIdentifier:(NSString *)restorationIdentifier;
@end

@protocol UIApplicationDelegate<NSObject>

@optional

- (void)applicationDidFinishLaunching:(UIApplication *)application;
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)applicationSignificantTimeChange:(UIApplication *)application;

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration;
- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation;

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame;
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler;

- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application;
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application;

@property (nonatomic, retain) UIWindow *window;

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window;

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

- (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder;
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder;
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder;
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder;
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder;

@end

@interface UIApplication(UIApplicationDeprecated)

@property(nonatomic,getter=isProximitySensingEnabled) BOOL proximitySensingEnabled;// NS_DEPRECATED_IOS(2_0, 3_0);
- (void)setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated;// NS_DEPRECATED_IOS(2_0, 3_2);

@end

UIKIT_EXTERN int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);

UIKIT_EXTERN NSString *const UITrackingRunLoopMode;

UIKIT_EXTERN NSString *const UIApplicationDidEnterBackgroundNotification;
UIKIT_EXTERN NSString *const UIApplicationWillEnterForegroundNotification;
UIKIT_EXTERN NSString *const UIApplicationDidFinishLaunchingNotification;
UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationWillResignActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationDidReceiveMemoryWarningNotification;
UIKIT_EXTERN NSString *const UIApplicationWillTerminateNotification;
UIKIT_EXTERN NSString *const UIApplicationSignificantTimeChangeNotification;
UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarOrientationNotification;
UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarOrientationNotification;
UIKIT_EXTERN NSString *const UIApplicationStatusBarOrientationUserInfoKey;
UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarFrameNotification;
UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarFrameNotification;
UIKIT_EXTERN NSString *const UIApplicationStatusBarFrameUserInfoKey;
UIKIT_EXTERN NSString *const UIApplicationBackgroundRefreshStatusDidChangeNotification;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsURLKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsSourceApplicationKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsRemoteNotificationKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsLocalNotificationKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsAnnotationKey;
UIKIT_EXTERN NSString *const UIApplicationProtectedDataWillBecomeUnavailable;
UIKIT_EXTERN NSString *const UIApplicationProtectedDataDidBecomeAvailable;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsLocationKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsNewsstandDownloadsKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsBluetoothCentralsKey;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsBluetoothPeripheralsKey;

// Content size category constants
UIKIT_EXTERN NSString *const UIContentSizeCategoryExtraSmall;
UIKIT_EXTERN NSString *const UIContentSizeCategorySmall;
UIKIT_EXTERN NSString *const UIContentSizeCategoryMedium;
UIKIT_EXTERN NSString *const UIContentSizeCategoryLarge;
UIKIT_EXTERN NSString *const UIContentSizeCategoryExtraLarge;
UIKIT_EXTERN NSString *const UIContentSizeCategoryExtraExtraLarge;
UIKIT_EXTERN NSString *const UIContentSizeCategoryExtraExtraExtraLarge;

// Accessibility sizes
UIKIT_EXTERN NSString *const UIContentSizeCategoryAccessibilityMedium;
UIKIT_EXTERN NSString *const UIContentSizeCategoryAccessibilityLarge;
UIKIT_EXTERN NSString *const UIContentSizeCategoryAccessibilityExtraLarge;
UIKIT_EXTERN NSString *const UIContentSizeCategoryAccessibilityExtraExtraLarge;
UIKIT_EXTERN NSString *const UIContentSizeCategoryAccessibilityExtraExtraExtraLarge;

// Notification is emitted when the user has changed the preferredContentSizeCategory for the system
UIKIT_EXTERN NSString *const UIContentSizeCategoryDidChangeNotification;
UIKIT_EXTERN NSString *const UIContentSizeCategoryNewValueKey;

UIKIT_EXTERN NSString *const UIApplicationUserDidTakeScreenshotNotification;
