//
//  TNSegmentedControlDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNSegmentedControlDemoViewController.h"

@interface TNSegmentedControlDemoViewController ()

@end

@implementation TNSegmentedControlDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"One",@"Two",@"Three"]];
    seg.center = CGPointMake(100, 130);
    [self.view addSubview:seg];
    
}

@end
