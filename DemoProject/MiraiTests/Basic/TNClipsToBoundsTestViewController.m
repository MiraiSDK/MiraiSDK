//
//  TNClipsToBoundsTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNClipsToBoundsTestViewController.h"

@interface TNClipsToBoundsTestViewController ()

@end

@implementation TNClipsToBoundsTestViewController

+ (NSString *)testName
{
    return @"clipsToBounds";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIScrollView *outerView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 400, 400)];
    
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 400, 400)];
    outerView.clipsToBounds = YES;
    outerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:outerView];

    
    UIScrollView *innerView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
//    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    innerView.backgroundColor = [UIColor purpleColor];
    innerView.clipsToBounds = YES;
    innerView.contentSize = CGSizeMake(400, 400);
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(-10, -10, 50, 50)];
    red.backgroundColor = [UIColor redColor];
    
    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(210, -10, 50, 50)];
    green.backgroundColor = [UIColor greenColor];
    
    UIView *yellow = [[UIView alloc] initWithFrame:CGRectMake(300, 250, 100, 100)];
    yellow.backgroundColor = [UIColor yellowColor];
    
    [innerView addSubview:red];
    [innerView addSubview:green];
    [innerView addSubview:yellow];
    
    [outerView addSubview:innerView];
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
