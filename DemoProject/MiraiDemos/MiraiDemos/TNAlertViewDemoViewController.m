//
//  TNAlertViewDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAlertViewDemoViewController.h"

@interface TNAlertViewDemoViewController ()

@end

@implementation TNAlertViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"alert" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(self.view.bounds.size.width/2, 150);
    [button addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert Tiele" message:@"Alert message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}


@end
