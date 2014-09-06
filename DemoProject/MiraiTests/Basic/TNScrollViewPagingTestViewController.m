//
//  TNScrollViewPagingTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/27/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNScrollViewPagingTestViewController.h"

@interface TNScrollViewPagingTestViewController ()

@end

@implementation TNScrollViewPagingTestViewController

+ (NSString *)testName
{
    return @"paging";
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
    
    NSInteger pageCount = 8;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(width * pageCount, height);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    for (int idx=0; idx<pageCount; idx++) {
        CGRect r = CGRectMake(width * idx, 0, width, height);
        UIView *view = [[UIView alloc] initWithFrame:r];
        CGFloat h = idx/(float)pageCount;
        view.backgroundColor = [UIColor colorWithHue:h saturation:1 brightness:1 alpha:1];
        [scrollView addSubview:view];
    }
}


@end
