//
//  TNPanGestureTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 9/21/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPanGestureTestViewController.h"

@interface TNPanGestureTestViewController ()

@end

@implementation TNPanGestureTestViewController

+ (NSString *)testName
{
    return @"Pan";
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
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 400, 400)];
    red.backgroundColor = [UIColor redColor];
    [self.view addSubview:red];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
    [red addGestureRecognizer:pan];

}

- (void)handle_pan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation = [pan translationInView:pan.view];
    NSLog(@"translation:%@",NSStringFromCGPoint(translation));
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
