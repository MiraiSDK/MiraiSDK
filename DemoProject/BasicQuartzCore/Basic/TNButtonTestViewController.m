//
//  TNButtonTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 3/31/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNButtonTestViewController.h"

@interface TNButtonTestViewController ()

@end

@implementation TNButtonTestViewController
+ (NSString *)testName
{
    return @"Button Test";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Pop" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    [self.view addSubview:button];
}

- (void)didPressedButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
