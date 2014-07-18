//
//  TNViewTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewTestViewController.h"
#import "TNCustomView.h"

@implementation TNViewTestViewController
+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UIView";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // custom view
//    TNCustomView *custom = [[TNCustomView alloc] initWithFrame:CGRectMake(0, 80, 300, 300)];
//    [self.view addSubview:custom];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    bgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bgView];
    
    // clip
    UIView *clipView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    clipView.clipsToBounds = YES;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 200, 200)];
    contentView.backgroundColor = [UIColor redColor];
    [clipView addSubview:contentView];

    [self.view addSubview:clipView];

}

@end
