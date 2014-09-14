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
#if __ANDROID__
    [[UIScreen mainScreen] setScreenMode:UIScreenSizeModePad scale:0];
#endif
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGRect bounds = CGRectMake(0, 0, 768, 1024);
//    bounds.origin.y = (screenBounds.size.height - bounds.size.height)/2;
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.backgroundColor = [UIColor blueColor];
    self.window.clipsToBounds = YES;
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

    NSLog(@"main bundle path:%@",[[NSBundle mainBundle] bundlePath]);

    //[self logPathSettings:NSUserDomainMask];
    
//    [self transformTest];
    
//    [self matrixTest];
//    [self maskBoundsTest];
    return YES;
}

- (void)maskBoundsTest
{
//    CALayer *bg = [CALayer layer];
//    bg.frame = CGRectMake(50, 50, 200, 200);
//    bg.backgroundColor = [UIColor lightGrayColor].CGColor;
//    [self.window.layer addSublayer:bg];

    CALayer *parent = [CALayer layer];
    parent.frame = CGRectMake(50, 50, 200, 200);
    parent.backgroundColor = [UIColor redColor].CGColor;
    parent.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    parent.masksToBounds = YES;
    
    CALayer *child = [CALayer layer];
    child.frame = CGRectMake(50, 50, 200, 200);
    child.backgroundColor = [UIColor greenColor].CGColor;
    child.masksToBounds = YES;

    CALayer *child11 = [CALayer layer];
    child11.frame = CGRectMake(50, 50, 200, 200);
    child11.backgroundColor = [UIColor yellowColor].CGColor;
    child11.masksToBounds = YES;
    [child addSublayer:child11];
    
    CALayer *child1 = [CALayer layer];
    child1.frame = CGRectMake(-150, -150, 200, 200);
    child1.backgroundColor = [UIColor purpleColor].CGColor;
    child1.masksToBounds = YES;
    

    
    [parent addSublayer:child];
    [parent addSublayer:child1];
    
    [self.window.layer addSublayer:parent];
    
    CALayer *p1 = [CALayer layer];
    p1.frame = CGRectMake(350, 50, 200, 200);
    p1.backgroundColor = [UIColor redColor].CGColor;
    p1.masksToBounds = YES;
    
    CALayer *c1 = [CALayer layer];
    c1.frame = CGRectMake(50, 50, 200, 200);
    c1.backgroundColor = [UIColor greenColor].CGColor;
    c1.masksToBounds = YES;
    
    CALayer *c2 = [CALayer layer];
    c2.frame = CGRectMake(-150, -150, 200, 200);
    c2.backgroundColor = [UIColor purpleColor].CGColor;
    c2.masksToBounds = YES;

    [p1 addSublayer:c1];
    [p1 addSublayer:c2];
    
    [self.window.layer addSublayer:p1];
}

- (void)layerConvertTest
{
    //    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 500, 500)];
    //    yellowView.backgroundColor = [UIColor yellowColor];
    //    [self.window addSubview:yellowView];
    //
    //    UIView *whiteview = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 400, 300)];
    //    whiteview.backgroundColor = [UIColor whiteColor];
    //    whiteview.transform = CGAffineTransformMakeRotation(M_PI_2);
    //    [yellowView addSubview:whiteview];
    //
    //    UIView *greenview = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 200, 100)];
    //    greenview.backgroundColor = [UIColor greenColor];
    //    [whiteview addSubview:greenview];
    //
    //    UIView *grayview = [[UIView alloc] initWithFrame:CGRectMake(120, 550, 500, 300)];
    //    grayview.backgroundColor = [UIColor grayColor];
    //    [self.window addSubview:grayview];
    //
    //    CGRect r = [whiteview convertRect:whiteview.bounds toView:yellowView];
    //    CGRect r2 = [whiteview convertRect:whiteview.bounds toView:grayview];
    //
    //    CGRect r3 = [greenview convertRect:greenview.bounds toView:yellowView];
    //
    //    NSLog(@"convert whiteview bounds:%@ to yellowView, result:%@",NSStringFromCGRect(whiteview.bounds),NSStringFromCGRect(r));
    //    CGRect r1 = [whiteview.layer convertRect:whiteview.layer.bounds toLayer:yellowView.layer];
    //    NSLog(@"convert whitelayer bounds:%@ to yellowlayer, result:%@",NSStringFromCGRect(whiteview.layer.bounds),NSStringFromCGRect(r1));
    //
    //    NSLog(@"convert whiteview bounds:%@ to grayview, result:%@",NSStringFromCGRect(whiteview.bounds),NSStringFromCGRect(r2));
    //
    //    NSLog(@"convert greenview bounds:%@ to yellowView, result:%@",NSStringFromCGRect(greenview.bounds),NSStringFromCGRect(r3));
    
    //    CGRect rrr = [greenview.layer convertRect:greenview.layer.bounds toLayer:yellowView.layer];
    //    CGRect r = [v11.layer convertRect:v11.layer.bounds toLayer:v.layer];
    //    NSLog(@"convert v11 layer bounds:%@ to v, result:%@",NSStringFromCGRect(greenview.layer.bounds),NSStringFromCGRect(rrr));

}
- (void)matrixTest
{
    CGAffineTransform t = CGAffineTransformMake(1.406250, 0, 0, 1.406250, -160.3125, -340.3125);
    CGAffineTransform t1 = CGAffineTransformInvert(t);
    
    
    CATransform3D t3d = CATransform3DMakeAffineTransform(t);
    CATransform3D i3d = CATransform3DInvert(t3d);
    CGAffineTransform t11 = CATransform3DGetAffineTransform(i3d);
    
    NSLog(@"t:%@",NSStringFromCGAffineTransform(t));
    NSLog(@"t1:%@",NSStringFromCGAffineTransform(t1));
    
    NSLog(@"t11:%@",NSStringFromCGAffineTransform(t11));

    NSLog(@"concat:%@",NSStringFromCGAffineTransform(CGAffineTransformConcat(t, t1)));
}

NSString *NSStringFromCATransform3D(CATransform3D t)
{
    return [NSString stringWithFormat:@"{%.8f %.8f %.8f %.8f,\n%.8f %.8f %.8f %.8f,\n%.8f %.8f %.8f %.8f,\n%.8f %.8f %.8f %.8f}",t.m11,t.m12,t.m13,t.m14,
            t.m21,t.m22,t.m23,t.m24,
            t.m31,t.m32,t.m33,t.m34,
            t.m41,t.m42,t.m43,t.m44];
}
- (void)transformTest
{
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 400, 300)];
    whiteView1.transform = CGAffineTransformMakeRotation(M_PI_2);

    CALayer *child = whiteView1.layer;

    CGPoint parentAnchorFix = CGPointMake(250, 250);

    CGPoint childAnchorFix = CGPointMake(200, 150);
    CGPoint anchorPosition = CGPointMake(child.position.x - parentAnchorFix.x,
                                         child.position.y - parentAnchorFix.y);
    
    CATransform3D anchorTranslate = CATransform3DMakeTranslation(anchorPosition.x, anchorPosition.y, 0);
    CATransform3D childTransform = child.transform;
    
    CATransform3D anchorTransform = CATransform3DConcat(childTransform,anchorTranslate);
    CGAffineTransform cg_anchorTransform = CATransform3DGetAffineTransform(anchorTransform);

    CGPoint child_view_coord_point = CGPointZero;
    CGPoint child_anchor_coord_point = CGPointMake(child_view_coord_point.x - childAnchorFix.x,
                                                   child_view_coord_point.y - childAnchorFix.y);
    
    CGPoint converted_anchor_point = CGPointApplyAffineTransform(child_anchor_coord_point, cg_anchorTransform);
    CGPoint converted_view_point = CGPointMake(converted_anchor_point.x + parentAnchorFix.x,
                                               converted_anchor_point.y + parentAnchorFix.y);
    
    CGRect r = CGRectMake(0, 0, 50, 50);
    CGRect ar = CGRectOffset(r, -childAnchorFix.x, -childAnchorFix.y);
    CGRect car = CGRectApplyAffineTransform(ar, cg_anchorTransform);
    CGRect cvr = CGRectOffset(car, parentAnchorFix.x, parentAnchorFix.y);
    
    NSLog(@"3d transform:%@",NSStringFromCATransform3D(anchorTransform));
    NSLog(@"affine transform:%@",NSStringFromCGAffineTransform(cg_anchorTransform));
    NSLog(@"vp:%@ ap:%@ cap:%@ cvp:%@",NSStringFromCGPoint(child_view_coord_point),NSStringFromCGPoint(child_anchor_coord_point),NSStringFromCGPoint(converted_anchor_point),NSStringFromCGPoint(converted_view_point));
    NSLog(@"vr:%@ ar:%@ car:%@ cvr:%@",NSStringFromCGRect(r),NSStringFromCGRect(ar),NSStringFromCGRect(car),NSStringFromCGRect(cvr));
}
- (void)logPathSettings:(NSSearchPathDomainMask)mask
{
    NSLog(@"domain:%d",mask);
    NSLog(@"NSDocumentDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:mask]);
    NSLog(@"NSLibraryDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:mask]);
    NSLog(@"NSCachesDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:mask]);
    NSLog(@"NSApplicationDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSApplicationDirectory inDomains:mask]);
    NSLog(@"NSUserDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSUserDirectory inDomains:mask]);
    NSLog(@"NSDocumentationDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory inDomains:mask]);
    NSLog(@"NSDesktopDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDesktopDirectory inDomains:mask]);
    NSLog(@"NSApplicationSupportDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:mask]);
    NSLog(@"NSDownloadsDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDownloadsDirectory inDomains:mask]);

    NSLog(@"NSDemoApplicationDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDemoApplicationDirectory inDomains:mask]);
    NSLog(@"NSDeveloperApplicationDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDeveloperApplicationDirectory inDomains:mask]);
    NSLog(@"NSAdminApplicationDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSAdminApplicationDirectory inDomains:mask]);

    NSLog(@"NSDeveloperDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSDeveloperDirectory inDomains:mask]);
//    NSLog(@"NSAutosavedInformationDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSAutosavedInformationDirectory inDomains:mask]);

//    NSLog(@"NSInputMethodsDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSInputMethodsDirectory inDomains:mask]);
//    NSLog(@"NSMoviesDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSMoviesDirectory inDomains:mask]);
//    NSLog(@"NSMusicDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSMusicDirectory inDomains:mask]);
//    NSLog(@"NSPicturesDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSPicturesDirectory inDomains:mask]);
//    NSLog(@"NSPrinterDescriptionDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSPrinterDescriptionDirectory inDomains:mask]);
//    NSLog(@"NSSharedPublicDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSSharedPublicDirectory inDomains:mask]);
//
//    NSLog(@"NSPreferencePanesDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSPreferencePanesDirectory inDomains:mask]);
//    NSLog(@"NSItemReplacementDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSItemReplacementDirectory inDomains:mask]);
    NSLog(@"NSAllApplicationsDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSAllApplicationsDirectory inDomains:mask]);
    NSLog(@"NSAllLibrariesDirectory:%@",[[NSFileManager defaultManager] URLsForDirectory:NSAllLibrariesDirectory inDomains:mask]);

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
