//
//  TNCGImageResultViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCGImageResultViewController.h"

@interface TNCGImageResultViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TNCGImageResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView = imageView;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
