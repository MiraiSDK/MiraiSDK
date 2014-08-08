//
//  main.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TNAppDelegate.h"

#ifdef __ANDROID__
#import <android/log.h>
//#import "CGContext-private.h"
#define  LOG_TAG    "BasicCairo"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#endif

int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([TNAppDelegate class]));
    }
    return 0;
}


#ifdef __ANDROID__

@interface TNAndroidLauncher : NSObject
@end
@implementation TNAndroidLauncher (User)
+ (void)launchWithArgc:(int)argc argv:(char *[])argv
{
    LOGI("in launcher");
    main(argc,argv);
}

@end
#endif

