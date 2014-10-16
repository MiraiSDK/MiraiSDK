//
//  TNScrollViewNestingTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/16/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNScrollViewNestingTestViewController.h"

@interface TNScrollViewNestingTestViewController ()

@end

@implementation TNScrollViewNestingTestViewController

+ (NSString *)testName
{
    return @"Nesting";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *outer = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 50, 300, 400)];
    outer.backgroundColor = [UIColor purpleColor];
    outer.contentSize = CGSizeMake(600, 400);
    [self.view addSubview:outer];
    
    UIScrollView *inner = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    inner.backgroundColor = [UIColor blueColor];
    inner.contentSize = CGSizeMake(400, 200);
    [outer addSubview:inner];
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 50, 50)];
    red.backgroundColor = [UIColor redColor];
    [outer addSubview:red];
    
    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 50, 50)];
    green.backgroundColor = [UIColor greenColor];
    [inner addSubview:green];
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
