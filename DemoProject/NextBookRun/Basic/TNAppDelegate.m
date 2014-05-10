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

#include <unistd.h>

@implementation TNAppDelegate
//@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread setCurrentThreadAsMainThread];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TNViewController *vc = [[TNViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    
    [self.window makeKeyAndVisible];
    
    dispatch_queue_t queue = dispatch_queue_create("stdErrlogQueue", NULL);
    dispatch_async(queue, ^{
        [self forwardStdErrToNSLog];
    });
    
    dispatch_queue_t outqueue = dispatch_queue_create("stdoutlogQueue", NULL);
    dispatch_async(outqueue, ^{
        [self forwardStdOutToNSLog];
    });

    return YES;
}

- (void)forwardStdErrToNSLog
{
    int pipes[2];
    pipe(pipes);
    dup2(pipes[1], STDERR_FILENO);
    FILE *inputFile = fdopen(pipes[0], "r");
    char readBuffer[256];
    while (1) {
        fgets(readBuffer, sizeof(readBuffer), inputFile);
        NSLog(@"[STDERR]:%s",readBuffer);
    }

}

- (void)forwardStdOutToNSLog
{
    int pipes[2];
    pipe(pipes);
    dup2(pipes[1], STDOUT_FILENO);
    FILE *inputFile = fdopen(pipes[0], "r");
    char readBuffer[256];
    while (1) {
        printf("try std out");
        fgets(readBuffer, sizeof(readBuffer), inputFile);
        NSLog(@"[STDOUT]:%s",readBuffer);
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
