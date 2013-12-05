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
//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "TNAppDelegate.h"

#define DEBUG_TAG "MainHActivity"

int main(int argc, char * argv[])
{
    __android_log_print(ANDROID_LOG_DEBUG, DEBUG_TAG, "NDK: main");

    @autoreleasepool {
        NSString *lll = @"hello";
        __android_log_print(ANDROID_LOG_DEBUG, DEBUG_TAG, "NDK: in autoreleasepool");
        NSNumber *a = [NSNumber numberWithInteger:1];
        NSNumber *b = [NSNumber numberWithInteger:2];
        
        return 0;
//        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([TNAppDelegate class]));
    }
    return 0;
}


void
Java_org_tiny4_Basic_MainHActivity_nativeOnCreate(JNIEnv * env, jobject this)
{
    main(0, NULL);
}

