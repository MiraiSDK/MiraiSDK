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

#include <EGL/egl.h>
#include <GLES2/gl2.h>

#define ANDROID 1
#import <OpenGLES/EAGL.h>


@interface TNAndroidLauncher : NSObject
+ (void)launchWithArgc:(int)argc argv:(char *[])argv;
@end
@implementation TNAndroidLauncher
@end

@interface UIApplication ()

@end

@implementation UIApplication {
    BOOL _isRunning;
    EAGLContext *_context;
    CARenderer *_renderer;
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

/**
 * Shared state for our app.
 */
struct engine {
    struct android_app* app;
    
    int animating;
    EGLDisplay display;
    EGLSurface surface;
    EGLContext context;
    int32_t width;
    int32_t height;
};

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
        struct engine engine;
        memset(&engine, 0, sizeof(engine));
        app_state->userData = &engine;
        app_state->onAppCmd = handle_app_command;
        app_state->onInputEvent = handle_input;
        engine.app = app_state;
        
        NSLog(@"start loop");
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
//                int pollTimeout = engine.animating ? 0 : -1;
                int pollTimeout = 0;
                while ((ident=ALooper_pollAll(pollTimeout, NULL, &events, (void**)&source)) >= 0) {
                    NSLog(@"handle event");
                    // Process this event.
                    if (source != NULL) {
                        source->process(app_state, source);
                    }

                    // Check if we are exiting.
                    if (app_state->destroyRequested != 0) {
                        NSLog(@"Engine thread destroy requested!");
                        engine_term_display(&engine);
                        return;
                    }
                }

                if (!UIGraphicsGetCurrentContext()) {
                    UIGraphicsBeginImageContext(CGSizeMake(engine.width, engine.height));
                }
                
                @autoreleasepool {
                    _renderer.layer = _app.keyWindow.layer;
                    [_renderer beginFrameAtTime:CACurrentMediaTime() timeStamp:NULL];
                    [_renderer render];
                    [_renderer endFrame];
                }

                eglSwapBuffers(engine.display, engine.surface);
                
            }
        } while (_isRunning);
    }

    NSLog(@"end running");

}


/**
 * Initialize an EGL context for the current display.
 */
static int engine_init_display(struct engine* engine) {
    // initialize OpenGL ES and EGL
    
    /*
     * Here specify the attributes of the desired configuration.
     * Below, we select an EGLConfig with at least 8 bits per color
     * component compatible with on-screen windows
     */
    const EGLint attribs[] = {
        EGL_CONFORMANT, EGL_OPENGL_ES2_BIT,
        EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
        EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
        EGL_BLUE_SIZE, 8,
        EGL_GREEN_SIZE, 8,
        EGL_RED_SIZE, 8,
        EGL_NONE
    };
    EGLint w, h, dummy, format;
    EGLint numConfigs;
    EGLConfig config;
    EGLSurface surface;
    EGLContext context;
    
    EGLDisplay display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
    
    eglInitialize(display, 0, 0);
    
    /* Here, the application chooses the configuration it desires. In this
     * sample, we have a very simplified selection process, where we pick
     * the first EGLConfig that matches our criteria */
    eglChooseConfig(display, attribs, &config, 1, &numConfigs);
    
    /* EGL_NATIVE_VISUAL_ID is an attribute of the EGLConfig that is
     * guaranteed to be accepted by ANativeWindow_setBuffersGeometry().
     * As soon as we picked a EGLConfig, we can safely reconfigure the
     * ANativeWindow buffers to match, using EGL_NATIVE_VISUAL_ID. */
    eglGetConfigAttrib(display, config, EGL_NATIVE_VISUAL_ID, &format);
    
    ANativeWindow_setBuffersGeometry(engine->app->window, 0, 0, format);
    
    surface = eglCreateWindowSurface(display, config, engine->app->window, NULL);
    context = eglCreateContext(display, config, NULL, NULL);
    
    if (eglMakeCurrent(display, surface, surface, context) == EGL_FALSE) {
        NSLog(@"Unable to eglMakeCurrent");
        return -1;
    }
    
    eglQuerySurface(display, surface, EGL_WIDTH, &w);
    eglQuerySurface(display, surface, EGL_HEIGHT, &h);
    
    engine->display = display;
    engine->context = context;
    engine->surface = surface;
    engine->width = w;
    engine->height = h;
    
    NSLog(@"surface width:%d height:%d",w,h);
    // Initialize GL state.
    
    EAGLContext *ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    _app->_renderer = [CARenderer rendererWithEAGLContext:ctx options:nil];
    _app->_context = ctx;
    
    return 0;
}

/**
 * Tear down the EGL context currently associated with the display.
 */
static void engine_term_display(struct engine* engine) {
    if (engine->display != EGL_NO_DISPLAY) {
        eglMakeCurrent(engine->display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
        if (engine->context != EGL_NO_CONTEXT) {
            eglDestroyContext(engine->display, engine->context);
        }
        if (engine->surface != EGL_NO_SURFACE) {
            eglDestroySurface(engine->display, engine->surface);
        }
        eglTerminate(engine->display);
    }
    engine->animating = 0;
    engine->display = EGL_NO_DISPLAY;
    engine->context = EGL_NO_CONTEXT;
    engine->surface = EGL_NO_SURFACE;
    
    _app->_renderer = nil;
    _app->_context = nil;
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
    struct engine* engine = (struct engine*)app->userData;
    
    switch (cmd) {
        case APP_CMD_INIT_WINDOW:
            // The window is being shown, get it ready.
            if (engine->app->window != NULL) {
                engine_init_display(engine);
//                engine_draw_frame(engine);
            }
            break;
        case APP_CMD_TERM_WINDOW:
            // The window is being hidden or closed, clean it up.
            engine_term_display(engine);
            break;
        case APP_CMD_LOST_FOCUS:
            app_has_focus=false;
            // Also stop animating.
            engine->animating = 0;
//            engine_draw_frame(engine);
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


