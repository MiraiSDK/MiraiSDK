//
//  TNPCTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/3/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPCTestViewController.h"
#import "NBRadialGradientLayer.h"
#import "NBSSAnimation.h"

@interface TNPCTestViewController ()

@end

@implementation TNPCTestViewController

+ (NSString *)testName
{
    return @"Property Test";
}

+ (void)load
{
    [self regisiterTestClass:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NBSSAnimation *ss = [[NBSSAnimation alloc] init];
    ss.num2 = @1;
    ss.num = @12;
    
    NSLog(@"ss:%@",ss);
    
    
    NBRadialGradientLayer *ra = [NBRadialGradientLayer layer];
    ra.colors = @[];
    NSLog(@"ra:%@",ra);
//    [self.view.layer addSublayer:ra];
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
