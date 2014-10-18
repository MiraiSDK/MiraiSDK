//
//  TNTouchesCancelTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/18/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTouchesCancelTestViewController.h"

@interface TNTouchesView : UIView

@end
@implementation TNTouchesView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
@interface TNTouchesCancelTestViewController ()

@end


@implementation TNTouchesCancelTestViewController

+ (NSString *)testName
{
    return @"Touches Cancel";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TNTouchesView *tv = [[TNTouchesView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
    tv.backgroundColor = [UIColor redColor];
    [self.view addSubview:tv];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
    [tv addGestureRecognizer:pan];
    
}

- (void)handle_pan:(UIPanGestureRecognizer *)pan
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
