//
//  TNGestureRecognizerViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNGestureRecognizerViewController.h"
#import "TNPinchTestViewController.h"
#import "TNRotationTestViewController.h"
#import "TNPinchAndRotationViewController.h"
#import "TNTapGestureTestViewController.h"

@interface TNGestureRecognizerViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *subTests;

@end

@implementation TNGestureRecognizerViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"GestureRecognizer Test";
}

+ (NSArray *)subTests
{
    return @[[TNPinchTestViewController class],
             [TNRotationTestViewController class],
             [TNPinchAndRotationViewController class],
             [TNTapGestureTestViewController class],
             ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end
