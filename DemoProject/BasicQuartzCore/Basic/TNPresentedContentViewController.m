//
//  TNPresentedContentViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/18/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPresentedContentViewController.h"

@interface TNPresentedContentViewController ()

@end

@implementation TNPresentedContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didPressedCancelItem:)];
    self.navigationItem.leftBarButtonItems = @[left];
}

- (void)didPressedCancelItem:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentedContentViewControllerDidCancel:animated:)]) {
        [self.delegate presentedContentViewControllerDidCancel:self animated:YES];
    }
}

@end
