//
//  TNImageDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNImageDemoViewController.h"

@interface TNImageDemoViewController ()

@end

@implementation TNImageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"34912115.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 100, 320, 453);
    imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:imageView];
}

@end
