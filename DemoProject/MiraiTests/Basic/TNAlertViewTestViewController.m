//
//  TNAlertViewTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAlertViewTestViewController.h"

@interface TNLLL : NSObject

@end
@implementation TNLLL

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%s",__PRETTY_FUNCTION__);
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end

@interface TAWindow : UIWindow

@end
@implementation TAWindow

- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
@implementation TNAlertViewTestViewController {
    NSArray *_array;
    UIAlertView *_alertView;
}

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UIAlertView";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *item  = [[UIBarButtonItem alloc] initWithTitle:@"Alert" style:UIBarButtonItemStylePlain target:self action:@selector(showAlert:)];
    self.navigationItem.rightBarButtonItems = @[item];
}

- (void)showAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
//    _alertView = alert;
    
//    TNLLL *tll = [[TNLLL alloc] init];
//    NSValue *v = [NSValue valueWithNonretainedObject:tll];
//    _array = @[v];
//    
//    NSLog(@"keyWindow:%@",[UIApplication sharedApplication].keyWindow);
//    TAWindow *w = [[TAWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [w makeKeyAndVisible];
//    NSLog(@"keyWindow:%@",[UIApplication sharedApplication].keyWindow);
//    [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:1.5];
    [self performSelector:@selector(logKeyWindow) withObject:nil afterDelay:5];
}

- (void)dismissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)logKeyWindow
{
    NSLog(@"keyWindow:%@",[UIApplication sharedApplication].keyWindow);
}

@end
