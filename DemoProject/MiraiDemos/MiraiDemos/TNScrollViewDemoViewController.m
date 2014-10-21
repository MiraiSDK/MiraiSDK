//
//  TNScrollViewDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNScrollViewDemoViewController.h"

@interface TNScrollViewDemoViewController ()

@end

@implementation TNScrollViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *s = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    s.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    red.backgroundColor = [UIColor redColor];
    [s addSubview:red];

    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 200, 300)];
    green.backgroundColor = [UIColor greenColor];
    [s addSubview:green];

    [self.view addSubview:s];
}

@end
