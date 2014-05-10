//
//  TNAppDelegate.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "TNViewController.h"
#import <dispatch/dispatch.h>
//#include <android/log.h>
#define  LOG_TAG    "BasicCairo"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)

#import "TNCustomView.h"

@implementation TNAppDelegate
//@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(20, 20, 500, 500);
//    label.layer.backgroundColor = [[UIColor greenColor] CGColor];
//    label.text = [NSString stringWithFormat:@"Hello Label \n中文能支持\n日本語もOKです。"];
//    [label setTextColor:[UIColor redColor]];
//    [self.window addSubview:label];
//
    
    TNViewController *vc = [[TNViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
//    TNCustomView *custom = [[TNCustomView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
//    [self.window addSubview:custom];

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"Pop" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor greenColor]];
//    [button setFrame:CGRectMake(0, 0, 300, 200)];
//    [self.window addSubview:button];
//    [button layoutSubviews];
    
    [self.window makeKeyAndVisible];
//    NSLog(@"before queue");
//    dispatch_queue_t queue = dispatch_queue_create("org.tiny4.sample", NULL);
//    dispatch_async(queue, ^{
//        NSLog(@"in async queue.....");
//    });
//    NSLog(@"dispatch async queue");
    
    
//    LOGI("start dispatch");
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        LOGI("running dispatch");
//    });
//    LOGI("end dispatch");
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
