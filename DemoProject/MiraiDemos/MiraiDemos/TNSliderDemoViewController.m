//
//  TNSliderDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNSliderDemoViewController.h"

@interface TNSliderDemoViewController ()

@end

@implementation TNSliderDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(5, 100, 100, 44)];
    [self.view addSubview:slider];
    
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
