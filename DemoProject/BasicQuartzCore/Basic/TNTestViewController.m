//
//  TNTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 4/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTestViewController.h"

@interface TNTestViewController ()

@end

@implementation TNTestViewController

static NSMutableArray *testClasses = nil;

+ (void)regisiterTestClass:(Class)cls
{
    if (nil == testClasses) {
        testClasses = [NSMutableArray array];
    }
    
    if ([cls isSubclassOfClass: [TNTestViewController class]])
    {
        [testClasses addObject: cls];
    } else {
        [NSException raise: NSInvalidArgumentException format: @"+[TNTestViewController regisiterTestClass:] called with invalid class"];
    }
}

+ (NSArray *)tests
{
    return testClasses;
}

+ (NSString *)testName
{
    return @"Untitled Test";
}

- (NSString *)testDescription
{
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [[self class] testName];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *desc = [self testDescription];
    if (desc) {
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        descLabel.text = desc;
        [self.view addSubview:descLabel];
    }
}

@end
