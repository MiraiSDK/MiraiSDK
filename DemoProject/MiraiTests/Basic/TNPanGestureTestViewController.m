//
//  TNPanGestureTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 9/21/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPanGestureTestViewController.h"

@interface TNPanGestureTestViewController ()
@property (nonatomic, strong) UIView *red;
@end

@implementation TNPanGestureTestViewController

+ (NSString *)testName
{
    return @"Pan";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 400, 400)];
    red.backgroundColor = [UIColor redColor];
    [self.view addSubview:red];
    self.red = red;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
    [self.view addGestureRecognizer:pan];

}

- (void)handle_pan:(UIPanGestureRecognizer *)pan
{
//    CGPoint translation = [pan translationInView:pan.view];
//    NSLog(@"translation:%@",NSStringFromCGPoint(translation));
    CGPoint location = [pan locationInView:self.view];
    self.red.center = location;
    
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
