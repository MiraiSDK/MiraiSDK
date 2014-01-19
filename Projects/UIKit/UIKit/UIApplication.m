//
//  UIApplication.m
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIApplication.h"
#import <dispatch/dispatch.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIWindow.h>
#import <QuartzCore/QuartzCore.h>
#import "UIScreenPrivate.h"
#import "UIGraphics.h"

#include <string.h>
#include <jni.h>
#include <android/log.h>
#import <Foundation/NSObjCRuntime.h>
#include "android_native_app_glue.h"

@interface TNAndroidLauncher : NSObject
+ (void)launchWithArgc:(int)argc argv:(char *[])argv;
@end
@implementation TNAndroidLauncher
@end

@interface UIApplication ()

@end

@implementation UIApplication {
    BOOL _isRunning;
}

static UIApplication *_app;
+ (UIApplication *)sharedApplication
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _app = [[self alloc] init];
    });
    return _app;
}

- (id)init
{
    if (_app) {
        NSAssert(_app, @"You can't init application twice"); // should throw excption?
    }
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIWindow *)keyWindow
{
    return [self.delegate window];
}

- (void)finishLaunching
{
    NSLog(@"in finishLaunching...");
    NSLog(@"delegate: %s",[self.delegate description].UTF8String);
    if (self.delegate) {
        NSLog(@"will coll didfinish");
        [self.delegate application:self didFinishLaunchingWithOptions:nil];
    }
}

static void draw_frame(ANativeWindow_Buffer *buffer);
static void handle_app_command(struct android_app* app, int32_t cmd);
static int32_t handle_input(struct android_app* app, AInputEvent* event);
bool app_has_focus = false;
static struct android_app* app_state;

- (void)_run
{
    static BOOL didlaunch = NO;
    @autoreleasepool {
        _isRunning = YES;
        
        if (!didlaunch) {
            didlaunch = YES;
            @autoreleasepool {
                NSLog(@"will finish");
                [self finishLaunching];
                NSLog(@"did finish");

            }
        }
        
        // Make sure glue isn't stripped.
        app_dummy();

        app_state->userData = NULL;
        app_state->onAppCmd = handle_app_command;
        app_state->onInputEvent = handle_input;

        do {
            @autoreleasepool {
                // Read all pending events. If app_has_focus is true, then we are going
                // to read any events that are ready then render the screen. If we don't
                // have focus, we are going to block and spin around the poll loop until
                // we get focus again, preventing us from doing a bunch of rendering
                // when the app isn't even visible.
                int ident;
                int events;
                struct android_poll_source* source;
                while ((ident=ALooper_pollAll(app_has_focus ? 0 : -1, NULL, &events, (void**)&source)) >= 0) {
                    // Process this event.
                    if (source != NULL) {
                        source->process(app_state, source);
                    }

                    // Check if we are exiting.
                    if (app_state->destroyRequested != 0) {
                        NSLog(@"Engine thread destroy requested!");
                        return;
                    }
                }


                UIWindow *window = _app.keyWindow;
                if (window.layer.needsDisplay) {
                    /* Now that we've delt with input, draw stuff */
                    if (app_state->window != NULL) {
                        ANativeWindow_Buffer buffer;
                        if (ANativeWindow_lock(app_state->window, &buffer, NULL) < 0) {
                            NSLog(@"Unable to lock window buffer");
                            continue;
                        }
                        
                        
                        
                        NSLog(@"Draw frame");
                        NSDate *begin = [NSDate date];
                        draw_frame_cgcontext(&buffer);
                        NSTimeInterval usage = -[begin timeIntervalSinceNow];
                        NSLog(@"draw use time:%.2f seconds",usage);
                        
                        ANativeWindow_unlockAndPost(app_state->window);
                    }
                }
            }
        } while (_isRunning);
    }

}

static int32_t handle_input(struct android_app* app, AInputEvent* event) {
    /* app->userData is available here */
    
    if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_MOTION) {
        app_has_focus = true;
        int32_t action = AMotionEvent_getAction(event);
        if (action ==AMOTION_EVENT_ACTION_UP) {
            NSLog(@"touc screen up");
            UIWindow *window = _app.keyWindow;
//            [window.layer setNeedsDisplay];
        }
        return 1;
    } else if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_KEY) {
        NSLog(@"Key event: action=%d keyCode=%d metaState=0x%x",
             AKeyEvent_getAction(event),
             AKeyEvent_getKeyCode(event),
             AKeyEvent_getMetaState(event));
    }
    
    return 0;
}

static void handle_app_command(struct android_app* app, int32_t cmd) {
    /* app->userData is available here */
    
    switch (cmd) {
        case APP_CMD_INIT_WINDOW:
            app_has_focus=true;
            break;
        case APP_CMD_LOST_FOCUS:
            app_has_focus=false;
            break;
        case APP_CMD_GAINED_FOCUS:
            app_has_focus=true;
            break;
    }
}

static void _NSLog_android_log_handler (NSString *message)
{
    __android_log_write(ANDROID_LOG_INFO,"NSLog",[message UTF8String]);
}

//int main(int argc, char * argv[]);
void android_main(struct android_app* state)
{
    _NSLog_printf_handler = *_NSLog_android_log_handler;
    
    app_state = state;
    int argc = 1;
    char * argv[] = {"/data/local/fileName"};
    [NSProcessInfo initializeWithArguments:argv count:argc environment:NULL];
    NSLog(@"on android_main");

    [TNAndroidLauncher launchWithArgc:argc argv:argv];
}

static void draw_frame_cgcontext(ANativeWindow_Buffer *buffer) {
    UIWindow *window = _app.keyWindow;
    if (window.layer.needsDisplay) {
        CGSize windowSize = CGSizeMake(buffer->width, buffer->height);
        CGRect bounds = CGRectMake(0, 0, windowSize.width, windowSize.height);
//        NSLog(@"windowSize: width:%.2f, height:%.2f",windowSize.width,windowSize.height);
        
        // context options
        //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
        if (colorSpace == NULL) {NSLog(@"color space is NULL!!!");}
        
        switch (buffer ->format) {
            case WINDOW_FORMAT_RGBA_8888:
                NSLog(@"WINDOW_FORMAT_RGBA_8888");
                break;
            case WINDOW_FORMAT_RGBX_8888:
                NSLog(@"WINDOW_FORMAT_RGBX_8888");
                break;
            case WINDOW_FORMAT_RGB_565:
                NSLog(@"WINDOW_FORMAT_RGB_565");
                break;
                
            default:
                break;
        }

        int32_t bitsPerComponent = 8;
        int32_t bytesPerRow = buffer->stride * bitsPerComponent / 2 ;
        CGBitmapInfo info = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    
        CGContextRef ctx = CGBitmapContextCreate(buffer->bits,
                                                 buffer->width,
                                                 buffer->height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 info);
        CGContextConcatCTM(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, buffer->height));

        UIGraphicsPushContext(ctx);
        memset (buffer->bits,
                0, bytesPerRow * buffer->height);

        [window.layer displayIfNeeded];
        
        if (window.layer.contents) {
            CGContextDrawImage(ctx, window.bounds, window.layer.contents);
        }
        
#if BYTEORDER == LITTLEENDIAN
        //
        // WORKAROUND:
        // cairo use ARGB layout, means Alpha at upper bits, Blue at lowest bits
        // Android's RGBA, means Alpha at upper bits, Red at lowest bits
        // needs swap Red and Blue
        //
        NSLog(@"swap bits");
        if (buffer->format == WINDOW_FORMAT_RGBA_8888 ||
            buffer->format == WINDOW_FORMAT_RGBX_8888
            )
        {
            for (char * p = (char*)buffer->bits; p != (char*)buffer->bits+(4*buffer->stride*buffer->height); p+=4) {
                char x = p[0];
                p[0] = p[2];
                p[2] = x;
            }
        }
#endif

        UIGraphicsPopContext();
        CGContextRelease(ctx);
        
    }
    
}

static void buffTest(ANativeWindow_Buffer *buffer)
{
    //    int32_t idx = 0;
    //    int8_t *bytes = buffer->bits;
    //    int8_t r = 0;
    //    int8_t g = 0;
    //    int8_t b = 255;
    //    int8_t a = 255;
    //    for (int32_t y = 0; y <buffer->height; y++) {
    //        for (int32_t x = 0; x < bytesPerRow; x++) {
    //            int channel = x % 4;
    //            int8_t value = 0;
    //            switch (channel) {
    //                case 0: value = r; break;
    //                case 1: value = g; break;
    //                case 2: value = b; break;
    //                case 3: value = a; break;
    //                default:break;
    //            }
    //
    //            bytes[idx] = value;
    //            idx ++;
    //        }
    //    }
    
    int32_t *pixes = buffer->bits;
    int32_t idx = 0;
    for (int32_t y = 0; y <buffer->height; y++) {
        for (int32_t x = 0; x < buffer->width; x++) {
            pixes[idx] = 0xFF0000FF;
            idx++;
        }
    }
}

#pragma mark - 
- (void)beginIgnoringInteractionEvents
{
    NS_UNIMPLEMENTED_LOG;
}
- (void)endIgnoringInteractionEvents
{
    NS_UNIMPLEMENTED_LOG;
}
- (BOOL)isIgnoringInteractionEvents
{
    NS_UNIMPLEMENTED_LOG;
    return NO;
}

- (BOOL)openURL:(NSURL*)url
{
    NS_UNIMPLEMENTED_LOG;
    return NO;
}

- (BOOL)canOpenURL:(NSURL *)url
{
    NS_UNIMPLEMENTED_LOG;
    return NO;
}

- (void)sendEvent:(UIEvent *)event
{
    NS_UNIMPLEMENTED_LOG;
}

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event
{
    NS_UNIMPLEMENTED_LOG;
    return NO;
}

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void(^)(void))handler
{
    NS_UNIMPLEMENTED_LOG;
    return 0;
}

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)taskName expirationHandler:(void(^)(void))handler
{
    NS_UNIMPLEMENTED_LOG;
    return 0;
}

- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)setMinimumBackgroundFetchInterval:(NSTimeInterval)minimumBackgroundFetchInterval
{
    NS_UNIMPLEMENTED_LOG;
}

- (BOOL)setKeepAliveTimeout:(NSTimeInterval)timeout handler:(void(^)(void))keepAliveHandler
{
    NS_UNIMPLEMENTED_LOG;
    return NO;
}

- (void)clearKeepAliveTimeout
{
    NS_UNIMPLEMENTED_LOG;
}

@end

@implementation UIApplication (UIRemoteNotifications)

- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)unregisterForRemoteNotifications
{
    NS_UNIMPLEMENTED_LOG;
}

- (UIRemoteNotificationType)enabledRemoteNotificationTypes
{
    NS_UNIMPLEMENTED_LOG;
    return UIRemoteNotificationTypeNone;
}

@end

@implementation UIApplication (UILocalNotifications)

- (void)presentLocalNotificationNow:(UILocalNotification *)notification
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)scheduleLocalNotification:(UILocalNotification *)notification
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)cancelLocalNotification:(UILocalNotification *)notification
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)cancelAllLocalNotifications
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)setScheduledLocalNotifications:(NSArray *)scheduledLocalNotifications
{
    NS_UNIMPLEMENTED_LOG;
}

- (NSArray *)scheduledLocalNotifications
{
    NS_UNIMPLEMENTED_LOG;
    return nil;
}

@end

@implementation UIApplication (UIRemoteControlEvents)

- (void)beginReceivingRemoteControlEvents
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)endReceivingRemoteControlEvents
{
    NS_UNIMPLEMENTED_LOG;
}

@end

@implementation UIApplication (UIStateRestoration)

- (void)extendStateRestoration
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)completeStateRestoration
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)ignoreSnapshotOnNextApplicationLaunch
{
    NS_UNIMPLEMENTED_LOG;
}

+ (void) registerObjectForStateRestoration:(id<UIStateRestoring>)object restorationIdentifier:(NSString *)restorationIdentifier
{
    NS_UNIMPLEMENTED_LOG;
}

@end

@implementation UIApplication (UIApplicationDeprecated)

- (BOOL)isProximitySensingEnabled
{
    NS_UNIMPLEMENTED_LOG;
    return NO;
}

- (void)setProximitySensingEnabled:(BOOL)proximitySensingEnabled
{
    NS_UNIMPLEMENTED_LOG;
}

- (void)setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    NS_UNIMPLEMENTED_LOG;
}

@end

int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName)
{
    NSLog(@"enter UIApplicationMain");
    id<UIApplicationDelegate>delegate = nil;
    @autoreleasepool {
        if (![UIScreen mainScreen]) {
            UIScreen *screen = [[UIScreen alloc] initWithAndroidNativeWindow:app_state->window];
        }
        
        Class class = principalClassName ? NSClassFromString(principalClassName) : nil;
        if (!class) {}// TODO: load principalClassName from plist
        
        if (!class) {
            class = [UIApplication class];
        }
        
        UIApplication *app = [class sharedApplication];
        Class delegateClass = delegateClassName ? NSClassFromString(delegateClassName) : nil;
        
        if (delegateClass) {
            delegate = [[delegateClass alloc] init];
            app.delegate = delegate;
        }
    }
    
    [_app _run];
    

    return 0;
}

NSString *const UIApplicationInvalidInterfaceOrientationException = @"UIApplicationInvalidInterfaceOrientationException";

const UIBackgroundTaskIdentifier UIBackgroundTaskInvalid = 0;
const NSTimeInterval UIMinimumKeepAliveTimeout = 600.0; //seconds
const NSTimeInterval UIApplicationBackgroundFetchIntervalMinimum = 0.0;
const NSTimeInterval UIApplicationBackgroundFetchIntervalNever = INFINITY;


NSString *const UITrackingRunLoopModeKey = @"UITrackingRunLoopMode";
NSString *const UIApplicationDidEnterBackgroundNotificationKey = @"UIApplicationDidEnterBackgroundNotification";
NSString *const UIApplicationWillEnterForegroundNotificationKey = @"UIApplicationWillEnterForegroundNotification";
NSString *const UIApplicationDidFinishLaunchingNotificationKey = @"UIApplicationDidFinishLaunchingNotification";
NSString *const UIApplicationDidBecomeActiveNotificationKey = @"UIApplicationDidBecomeActiveNotification";
NSString *const UIApplicationWillResignActiveNotificationKey = @"UIApplicationWillResignActiveNotification";
NSString *const UIApplicationDidReceiveMemoryWarningNotificationKey = @"UIApplicationDidReceiveMemoryWarningNotification";
NSString *const UIApplicationWillTerminateNotificationKey = @"UIApplicationWillTerminateNotification";
NSString *const UIApplicationSignificantTimeChangeNotificationKey = @"UIApplicationSignificantTimeChangeNotification";
NSString *const UIApplicationWillChangeStatusBarOrientationNotificationKey = @"UIApplicationWillChangeStatusBarOrientationNotification";
NSString *const UIApplicationDidChangeStatusBarOrientationNotificationKey = @"UIApplicationDidChangeStatusBarOrientationNotification";
NSString *const UIApplicationStatusBarOrientationUserInfoKeyKey = @"UIApplicationStatusBarOrientationUserInfoKey";
NSString *const UIApplicationWillChangeStatusBarFrameNotificationKey = @"UIApplicationWillChangeStatusBarFrameNotification";
NSString *const UIApplicationDidChangeStatusBarFrameNotificationKey = @"UIApplicationDidChangeStatusBarFrameNotification";
NSString *const UIApplicationStatusBarFrameUserInfoKeyKey = @"UIApplicationStatusBarFrameUserInfoKey";
NSString *const UIApplicationBackgroundRefreshStatusDidChangeNotificationKey = @"UIApplicationBackgroundRefreshStatusDidChangeNotification";
NSString *const UIApplicationLaunchOptionsURLKeyKey = @"UIApplicationLaunchOptionsURLKey";
NSString *const UIApplicationLaunchOptionsSourceApplicationKeyKey = @"UIApplicationLaunchOptionsSourceApplicationKey";
NSString *const UIApplicationLaunchOptionsRemoteNotificationKeyKey = @"UIApplicationLaunchOptionsRemoteNotificationKey";
NSString *const UIApplicationLaunchOptionsLocalNotificationKeyKey = @"UIApplicationLaunchOptionsLocalNotificationKey";
NSString *const UIApplicationLaunchOptionsAnnotationKeyKey = @"UIApplicationLaunchOptionsAnnotationKey";
NSString *const UIApplicationProtectedDataWillBecomeUnavailableKey = @"UIApplicationProtectedDataWillBecomeUnavailable";
NSString *const UIApplicationProtectedDataDidBecomeAvailableKey = @"UIApplicationProtectedDataDidBecomeAvailable";
NSString *const UIApplicationLaunchOptionsLocationKeyKey = @"UIApplicationLaunchOptionsLocationKey";
NSString *const UIApplicationLaunchOptionsNewsstandDownloadsKeyKey = @"UIApplicationLaunchOptionsNewsstandDownloadsKey";
NSString *const UIApplicationLaunchOptionsBluetoothCentralsKeyKey = @"UIApplicationLaunchOptionsBluetoothCentralsKey";
NSString *const UIApplicationLaunchOptionsBluetoothPeripheralsKeyKey = @"UIApplicationLaunchOptionsBluetoothPeripheralsKey";
NSString *const UIContentSizeCategoryExtraSmallKey = @"UIContentSizeCategoryExtraSmall";
NSString *const UIContentSizeCategorySmallKey = @"UIContentSizeCategorySmall";
NSString *const UIContentSizeCategoryMediumKey = @"UIContentSizeCategoryMedium";
NSString *const UIContentSizeCategoryLargeKey = @"UIContentSizeCategoryLarge";
NSString *const UIContentSizeCategoryExtraLargeKey = @"UIContentSizeCategoryExtraLarge";
NSString *const UIContentSizeCategoryExtraExtraLargeKey = @"UIContentSizeCategoryExtraExtraLarge";
NSString *const UIContentSizeCategoryExtraExtraExtraLargeKey = @"UIContentSizeCategoryExtraExtraExtraLarge";
NSString *const UIContentSizeCategoryAccessibilityMediumKey = @"UIContentSizeCategoryAccessibilityMedium";
NSString *const UIContentSizeCategoryAccessibilityLargeKey = @"UIContentSizeCategoryAccessibilityLarge";
NSString *const UIContentSizeCategoryAccessibilityExtraLargeKey = @"UIContentSizeCategoryAccessibilityExtraLarge";
NSString *const UIContentSizeCategoryAccessibilityExtraExtraLargeKey = @"UIContentSizeCategoryAccessibilityExtraExtraLarge";
NSString *const UIContentSizeCategoryAccessibilityExtraExtraExtraLargeKey = @"UIContentSizeCategoryAccessibilityExtraExtraExtraLarge";
NSString *const UIContentSizeCategoryDidChangeNotificationKey = @"UIContentSizeCategoryDidChangeNotification";
NSString *const UIContentSizeCategoryNewValueKeyKey = @"UIContentSizeCategoryNewValueKey";
NSString *const UIApplicationUserDidTakeScreenshotNotificationKey = @"UIApplicationUserDidTakeScreenshotNotification";


