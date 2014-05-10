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

static NSMutableArray *_testcases;
//+ (void)initialize
//{
//    [self testCases];
//}

//+ (void)registerTestCase
//{
//    NSMutableArray *t = (NSMutableArray *)[self testCases];
//    [t addObject:[self class]];
//}

+ (NSArray *)testCases
{
    if (_testcases == nil) {
        _testcases = [NSMutableArray array];
    }
    
    return _testcases;
}

+ (NSString *)testName
{
    return @"Test";
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
