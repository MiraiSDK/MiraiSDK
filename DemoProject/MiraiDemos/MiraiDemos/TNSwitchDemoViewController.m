//
//  TNSwitchDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNSwitchDemoViewController.h"

@interface TNSwitchDemoViewController ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UISwitch *sw;

@end

@implementation TNSwitchDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwitch *sw = [[UISwitch alloc] init];
    sw.center = CGPointMake(200, 130);
    [sw addTarget:self action:@selector(swChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sw];
    self.sw = sw;
    
    UILabel *sl = [[UILabel alloc] initWithFrame:CGRectMake(10, sw.frame.origin.y, 200, 33)];
    [self.view addSubview:sl];
    self.label = sl;
    
    [self swChanged:nil];
    
    UIButton *button1 =[UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Switch On" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(switchOn:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(10, 180, 100, 44);
    [button1 sizeToFit];
    [self.view addSubview:button1];
    
    UIButton *button2 =[UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"Switch Off" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(switchOff:) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(130, 180, 100, 44);
    [button2 sizeToFit];
    [self.view addSubview:button2];

}

- (void)swChanged:(id)sender
{
    self.label.text = [NSString stringWithFormat:@"switch: %@",self.sw.isOn ? @"On":@"Off"];
}

- (void)switchOn:(id)sender
{
    [self.sw setOn:YES animated:YES];
    [self swChanged:nil];

}

- (void)switchOff:(id)sender
{
    [self.sw setOn:NO animated:YES];
    [self swChanged:nil];
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
