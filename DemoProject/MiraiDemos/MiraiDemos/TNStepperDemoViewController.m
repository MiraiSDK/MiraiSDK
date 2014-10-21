//
//  TNStepperDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNStepperDemoViewController.h"

@interface TNStepperDemoViewController ()
@property (nonatomic, strong) UIStepper *stepper;
@property (nonatomic, strong) UILabel *label;

@end

@implementation TNStepperDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStepper *stepper = [[UIStepper alloc] init];
    stepper.center = CGPointMake(250, 130);
    [stepper addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
    self.stepper = stepper;

    UILabel *sl = [[UILabel alloc] initWithFrame:CGRectMake(10, stepper.frame.origin.y, 200, 33)];
    [self.view addSubview:sl];
    self.label = sl;

    [self stepperChanged:nil];
}

- (void)stepperChanged:(id)sender
{
    self.label.text = [NSString stringWithFormat:@"stepper value: %.0f",self.stepper.value];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
