//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <CoreText/CoreText.h>

@interface TNViewController ()

@end

@implementation TNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CTFramesetterCreateWithAttributedString(nil);
    
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"Action" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(50, 100, 100, 50)];
    
    [self.view addSubview:button];
}

- (void)showAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
