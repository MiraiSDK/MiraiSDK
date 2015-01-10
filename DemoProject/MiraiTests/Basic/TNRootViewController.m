//
//  TNRootViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 12/31/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNRootViewController.h"

@interface TNRootViewController ()

@end

@implementation TNRootViewController

- (void)dealloc
{
    NSLog(@"<%p> %s",self,__PRETTY_FUNCTION__);
    [super dealloc];
}

//+ (NSString *)testName
//{
//    return @"Navi Memory Test";
//}
//
//+ (void)load
//{
//    [self regisiterTestClass:self];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setTitle:@"switch" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(changeRoot:) forControlEvents:UIControlEventTouchUpInside];
//    [button sizeToFit];
//    button.center = CGPointMake(100, 200);
//    [self.view addSubview:button];
//    
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"pop" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    button1.center = CGPointMake(100, 500);
    [self.view addSubview:button1];
    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pop) userInfo:nil repeats:NO];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeRoot:(id)sender
{
    TNRootViewController *vc = [[TNRootViewController alloc] init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
