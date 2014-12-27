//
//  TNTextViewTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 12/15/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTextViewTestViewController.h"

@interface TNTextViewTestViewController ()

@end

@implementation TNTextViewTestViewController

+ (NSString *)testName
{
    return @"UITextView Test";
}

+ (void)load
{
    [self regisiterTestClass:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textview = [[UITextView alloc] initWithFrame:self.view.bounds];
    textview.text = @"Created by Chen Yonghui on 12/15/14.\n  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.";
    [self.view addSubview:textview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
