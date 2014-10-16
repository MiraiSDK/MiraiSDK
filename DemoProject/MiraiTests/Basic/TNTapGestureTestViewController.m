//
//  TNTapGestureTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/7/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTapGestureTestViewController.h"

@interface TNTapGestureTestViewController ()

@end

@implementation TNTapGestureTestViewController

+ (NSString *)testName
{
    return @"Tap";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap:)];
    [self.view addGestureRecognizer:tap];
    

    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    subview.backgroundColor = [UIColor redColor];
    [self.view addSubview:subview];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap2:)];
    [subview addGestureRecognizer:tap2];
}

- (void)handle_tap:(UIGestureRecognizer *)ges
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)handle_tap2:(UIGestureRecognizer *)ges
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
