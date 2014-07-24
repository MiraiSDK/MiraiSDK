//
//  TNCTTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCTTestViewController.h"
#import "TNCTView.h"

@interface TNCTTestViewController ()

@end

@implementation TNCTTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Core Text Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TNCTView *v = [[TNCTView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}


@end
