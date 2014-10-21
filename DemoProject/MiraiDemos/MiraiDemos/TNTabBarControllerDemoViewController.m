//
//  TNTabControllerDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTabBarControllerDemoViewController.h"

@interface TNTabBarContentViewController : UIViewController
@property (nonatomic, weak) UIViewController *caller;
@end
@implementation TNTabBarContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismissTBC:) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    button1.center = CGPointMake(self.view.bounds.size.width/2, 100);
    [self.view addSubview:button1];
}

- (void)dismissTBC:(id)sender
{
    [self.caller dismissViewControllerAnimated:YES completion:nil];
}
@end

@interface TNTabBarControllerDemoViewController ()

@end

@implementation TNTabBarControllerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"show TabBarController" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showTBC:) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    button1.center = CGPointMake(self.view.bounds.size.width/2, 100);
    [self.view addSubview:button1];
    
}

- (void)showTBC:(id)sender
{
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    TNTabBarContentViewController *v1 = [[TNTabBarContentViewController alloc] init];
    v1.title = @"tab 1";
    v1.caller = self;
    v1.view.backgroundColor = [UIColor redColor];
    TNTabBarContentViewController *v2 = [[TNTabBarContentViewController alloc] init];
    v2.title = @"tab 2";
    v2.view.backgroundColor = [UIColor greenColor];
    v2.caller = self;
    tbc.viewControllers = @[v1,v2];

    [self presentViewController:tbc animated:YES completion:nil];
}
@end
