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


                /* Now that we've delt with input, draw stuff */
                if (app_state->window != NULL) {
                    ANativeWindow_Buffer buffer;
                    if (ANativeWindow_lock(app_state->window, &buffer, NULL) < 0) {
                        NSLog(@"Unable to lock window buffer");
                        continue;
                    }
                    

                    
                    NSLog(@"Draw frame");
                    draw_frame_cgcontext(&buffer);
                    
                    ANativeWindow_unlockAndPost(app_state->window);
                }
            }
        } while (_isRunning);
    }

}

static int32_t handle_input(struct android_app* app, AInputEvent* event) {
    /* app->userData is available here */
    
    if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_MOTION) {
        app_has_focus = true;
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
    CGSize windowSize = CGSizeMake(buffer->width, buffer->height);
    CGRect bounds = CGRectMake(0, 0, windowSize.width, windowSize.height);
    NSLog(@"windowSize: width:%.2f, height:%.2f",windowSize.width,windowSize.height);
    
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
    memset (buffer->bits,
            0, bytesPerRow * buffer->height);
    
    CGContextRef ctx = CGBitmapContextCreate(buffer->bits,
                                             buffer->width,
                                             buffer->height,
                                             bitsPerComponent,
                                             bytesPerRow,
                                             colorSpace,
                                             info);
    UIGraphicsPushContext(ctx);
    UIWindow *window = _app.keyWindow;
    [window.layer display];
    UIGraphicsPopContext();
    
    CGContextFillRect(ctx, bounds);
    
#if BYTEORDER == LITTLEENDIAN
    //
    // WORKAROUND:
    // cairo use ARGB layout, means Alpha at upper bits, Blue at lowest bits
    // Android's RGBA, means Alpha at upper bits, Red at lowest bits
    // needs swap Red and Blue
    //
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
    
    CGContextRelease(ctx);
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

NSString *const UIApplicationDidFinishLaunchingNotification = @"UIApplicationDidFinishLaunchingNotification";

