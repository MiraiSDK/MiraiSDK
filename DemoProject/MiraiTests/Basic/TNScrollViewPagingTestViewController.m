//
//  TNScrollViewPagingTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/27/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNScrollViewPagingTestViewController.h"

@interface TNScrollViewPagingTestViewController () <UIScrollViewDelegate>

@end

@implementation TNScrollViewPagingTestViewController

+ (NSString *)testName
{
    return @"paging";
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
    scrollView.delegate = self;
    
    scrollView.layer.borderWidth = 100;
    scrollView.layer.borderColor = [UIColor redColor].CGColor;

    [self.view addSubview:scrollView];
    
    for (int idx=0; idx<pageCount; idx++) {
        CGRect r = CGRectMake(width * idx, 0, width, height);
        UIView *view = [[UIView alloc] initWithFrame:r];
        CGFloat h = idx/(float)pageCount;
        view.backgroundColor = [UIColor colorWithHue:h saturation:1 brightness:1 alpha:1];
        [scrollView addSubview:view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
@end
