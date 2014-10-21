//
//  TNDatePickerDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNDatePickerDemoViewController.h"

@interface TNDatePickerDemoViewController ()

@end

@implementation TNDatePickerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 400, 100, 400)];
    [self.view addSubview:picker];
}


@end
