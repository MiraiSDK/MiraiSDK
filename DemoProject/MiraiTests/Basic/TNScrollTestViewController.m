//
//  TNScrollTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 4/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNScrollTestViewController.h"
#import "TNScrollViewPagingTestViewController.h"
#import "TNClipsToBoundsTestViewController.h"

@interface TNScrollTestViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *red;

@end

@implementation TNScrollTestViewController
+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UIScrollView";
}

+ (NSArray *)subTests
{
    return @[
             [TNScrollViewPagingTestViewController class],
             [TNClipsToBoundsTestViewController class],
             ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIScrollView *s = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    s.backgroundColor = [UIColor whiteColor];
//    
//    s.contentSize = CGSizeMake(self.view.bounds.size.width*2,
//                               self.view.bounds.size.height);
//    
//    [self.view addSubview:s];
//    self.scrollView = s;
//    
//    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(50, 250, 300, 150)];
//    red.backgroundColor = [UIColor redColor];
//    self.red = red;
//    [self.scrollView addSubview:red];
//    
//    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*2-50-300, 250, 300, 150)];
//    green.backgroundColor = [UIColor greenColor];
//    [self.scrollView addSubview:green];

    self.title = [[self class] testName];
}

#pragma mark - scrollTest
- (void)scrollTest1:(id)sender
{
    //    [self.scrollView scrollRectToVisible:CGRectMake(0, 1280, 720, 1280) animated:NO];
    //    NSLog(@"%@",self.scrollView);
    //    NSLog(@"scroll bounds:%@",NSStringFromCGRect(self.scrollView.bounds));
}

- (void)scrollTest2:(id)sender
{
    //    [self.scrollView scrollRectToVisible:self.view.bounds animated:NO];
    //    NSLog(@"%@",self.scrollView);
}
@end
