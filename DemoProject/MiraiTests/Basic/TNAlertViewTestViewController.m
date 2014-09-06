//
//  TNAlertViewTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAlertViewTestViewController.h"

@implementation TNAlertViewTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UIAlertView";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//- (void)showAlert:(id)sender
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//}

@end
