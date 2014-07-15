//
//  TNCGTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/10/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCGTestViewController.h"

@interface TNCGTestViewController ()

@end

@implementation TNCGTestViewController

+ (NSString *)testName
{
    return @"Core Graphics Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIColor *c = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [c setFill];
    
    UIColor *w = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [w setFill];

    UIGraphicsEndImageContext();
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
