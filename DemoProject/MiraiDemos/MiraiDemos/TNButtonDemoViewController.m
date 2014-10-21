//
//  TNButtonDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNButtonDemoViewController.h"

@interface TNButtonDemoViewController ()
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation TNButtonDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 44)];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel = statusLabel;
    [self.view addSubview:statusLabel];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Button1" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(10, 140, 100, 100);
    [button1 sizeToFit];
    
    [self.view addSubview:button1];
    

    
}

- (void)buttonPressed:(id)sender
{
    UIButton *button = sender;
    self.statusLabel.text = [NSString stringWithFormat:@"%@ pressed",[button titleForState:UIControlStateNormal]];
}

@end
