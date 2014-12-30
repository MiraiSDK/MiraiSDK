//
//  TNMemoryTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 12/27/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMemoryTestViewController.h"

@interface TNMemoryTestViewController ()
@property (nonatomic, strong) NSArray *sub;
@end

extern void Java_org_tiny4_CocoaActivity_CocoaActivity_nativeOnTrimMemory(int level);

@implementation TNMemoryTestViewController

+ (NSString *)testName
{
    return @"Memory Test";
}

+ (void)load
{
    [self regisiterTestClass:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Simulate Memory Warning" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(simulateMemoryWarning) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    UIImage *i = [UIImage imageNamed:@"ContentsGravity_Large.jpg"];
    
    [self.view addSubview:button];
    button.center = CGPointMake(100, 300);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memwarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)memwarning:(id)obj
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)simulateMemoryWarning
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
#if __ANDROID__
    Java_org_tiny4_CocoaActivity_CocoaActivity_nativeOnTrimMemory(5);
#endif    
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super didReceiveMemoryWarning];
}

@end
