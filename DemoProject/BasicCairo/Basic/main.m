//
//  main.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#include <stdio.h>

#include <string.h>
#include <jni.h>
#include <android/log.h>
#include "android_native_app_glue.h"
#include <cairo/cairo.h>

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>

//#import "TNAppDelegate.h"
//#import "CGContext-private.h"

#define DEBUG_TAG "MainHActivity"

@interface UIAppDelegate : NSObject

@end
@implementation UIAppDelegate

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

void render()
{
    //for screen in screens
    //  for window in screen.windows
    //      window.display

}

int UIApplicationMain(int argc, char *argv[], NSString *principalClassname, NSString *delegateClassName);
int UIApplicationMain(int argc, char *argv[], NSString *principalClassname, NSString *delegateClassName)
{
    
    UIAppDelegate *delegate = [[UIAppDelegate alloc] init];
    
    // Make sure glue isn't stripped.
    app_dummy();

    return 0;
}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, nil);
    }
    return 0;
}


#define  LOG_TAG    "BasicCairo_main"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGW(...)  __android_log_print(ANDROID_LOG_WARN,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

bool app_has_focus = false;
int  tick          = 0;

static void draw_frame(ANativeWindow_Buffer *buffer);
static void handle_app_command(struct android_app* app, int32_t cmd);
static int32_t handle_input(struct android_app* app, AInputEvent* event);

void android_main(struct android_app* state)
{
    int argc = 1;
    char * argv[] = {"/data/local/fileName"};
    char *env = NULL;
    [NSProcessInfo initializeWithArguments:argv count:argc environment:env];
    
    // Make sure glue isn't stripped.
    app_dummy();
//    sleep(5); //wait gdb

    state->userData = NULL;
    state->onAppCmd = handle_app_command;
    state->onInputEvent = handle_input;
    while (1) {
        @autoreleasepool {
            @try {
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
                        source->process(state, source);
                    }
                    
                    // Check if we are exiting.
                    if (state->destroyRequested != 0) {
                        LOGI("Engine thread destroy requested!");
                        return;
                    }
                }
                
                
                /* Now that we've delt with input, draw stuff */
                if (state->window != NULL) {
                    ++tick;
                    LOGI("Rendering frame %d", tick);
                    ANativeWindow_Buffer buffer;
                    if (ANativeWindow_lock(state->window, &buffer, NULL) < 0) {
                        LOGW("Unable to lock window buffer");
                        continue;
                    }
                    
                    draw_frame(&buffer);
                    
                    ANativeWindow_unlockAndPost(state->window);
                }
            }
            @catch (NSException *exception) {
                LOGE("exception: %s, reason:%s",[[exception name] UTF8String],[[exception reason] UTF8String]);
            }
            @finally {
                
            }
        }
    }

//    main(0, NULL);
}

static int32_t handle_input(struct android_app* app, AInputEvent* event) {
    /* app->userData is available here */
    
    if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_MOTION) {
        app_has_focus = true;
        return 1;
    } else if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_KEY) {
        LOGI("Key event: action=%d keyCode=%d metaState=0x%x",
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

static void draw_frame_cairo(ANativeWindow_Buffer *buffer) {
    int pixel_size = 0;
    cairo_surface_t *surface = NULL;
    
    /* Setup our cairo surface to render directly to the native window buffer */
    if (buffer->format == WINDOW_FORMAT_RGB_565) {
        pixel_size = 2;
        surface = cairo_image_surface_create_for_data(buffer->bits, CAIRO_FORMAT_RGB16_565, buffer->width, buffer->height, buffer->stride*pixel_size);
        LOGI("create surface with rgb16_565, width:%d, height:%d, bytesPerRow:%d",buffer->width,buffer->height,buffer->stride*pixel_size);

    } else if (buffer->format == WINDOW_FORMAT_RGBA_8888 || buffer->format == WINDOW_FORMAT_RGBX_8888) {
        pixel_size = 4;
        surface = cairo_image_surface_create_for_data(buffer->bits, CAIRO_FORMAT_RGB24, buffer->width, buffer->height, buffer->stride*pixel_size);
        LOGI("create surface with rgb24, width:%d, height:%d, bytesPerRow:%d",buffer->width,buffer->height,buffer->stride*pixel_size);
    } else {
        LOGE("Unsupported buffer format: %d", buffer->format);
        return;
    }
    
    cairo_t *cr = cairo_create(surface);
    
    /* clear the screen */
    memset(buffer->bits, 0, buffer->stride*pixel_size*buffer->height);
    
    /* Normalize our canvas size to make our lives easier */
//    cairo_scale(cr, buffer->width, buffer->height);
    
    cairo_rectangle (cr, 0, 0,buffer->width, buffer->height);
    cairo_set_source_rgba (cr, 1, 0, 0, 0.50);
    cairo_fill (cr);
    
    /* Clean up. */
    cairo_destroy(cr);
    cairo_surface_destroy(surface);
}

static void draw_frame_cgcontext(ANativeWindow_Buffer *buffer) {
    CGSize windowSize = CGSizeMake(buffer->width, buffer->height);
    CGRect bounds = CGRectMake(0, 0, windowSize.width, windowSize.height);
    LOGI("windowSize: width:%.2f, height:%.2f",windowSize.width,windowSize.height);
    
    // context options
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {LOGI("color space is NULL!!!");}
    
    int bitsPerComponent = 8;
    int bytesPerRow = buffer->stride * bitsPerComponent / 2 ;
    CGBitmapInfo info = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;

    CGContextRef ctx = CGBitmapContextCreate(buffer->bits, buffer->width, buffer->height, bitsPerComponent, bytesPerRow, colorSpace, info);
    if (ctx == NULL) {LOGI("CGContextRef is NULL!!!");return;}
    
//    CGContextClearRect(ctx, bounds);
    CGColorRef color = CGColorCreateGenericRGB(1, 0, 0, 1);
    if (color == NULL) {LOGI("color is NULL!!!");return;}

    CGContextSetFillColorWithColor(ctx, color);
    CGContextFillRect(ctx, bounds);
    CGContextRelease(ctx);
}

static void draw_frame(ANativeWindow_Buffer *buffer) {
    LOGI("in draw frame");
//    draw_frame_cairo(buffer);
    draw_frame_cgcontext(buffer);

}

static void temp()
{
//    int bitsPerComponent = 4;
//    CGBitmapInfo info = kCGBitmapByteOrder32Little;
//    
//    switch (buffer->format) {
//        case WINDOW_FORMAT_RGBA_8888:
//        bitsPerComponent = 8;
//        info |= kCGImageAlphaNoneSkipFirst;
//        break;
//        case WINDOW_FORMAT_RGBX_8888:
//        bitsPerComponent = 8;
//        info |= kCGImageAlphaNoneSkipFirst;
//        break;
//        case WINDOW_FORMAT_RGB_565:
//        bitsPerComponent = 2;
//        break;
//        
//        default:break;
//    }


}