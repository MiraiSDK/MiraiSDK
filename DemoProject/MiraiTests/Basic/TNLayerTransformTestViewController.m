//
//  TNLayerTransformTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/29/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLayerTransformTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TNLayerTransformTestViewController ()

@end

@implementation TNLayerTransformTestViewController

+ (NSString *)testName
{
    return @"Layer Transform";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // first test CGAf
    CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 0.5);
    CGRect rect = CGRectMake(10, 10, 100, 100);
    CGRect rect1 = CGRectApplyAffineTransform(rect, scale);
    NSLog(@"test CGRectApplyAffineTransform: %@",NSStringFromCGAffineTransform(scale));
    NSLog(@"before:%@, after:%@",NSStringFromCGRect(rect),NSStringFromCGRect(rect1));

    
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:v1];
    

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    CGRect frame = v.frame;
    CGRect bounds = v.layer.bounds;
    v.transform = CGAffineTransformMakeScale(0.5, 0.5);
    CGRect frame1 = v.frame;
    CGRect bounds1 = v.layer.bounds;
    
    NSLog(@"frame before:%@ after:%@",NSStringFromCGRect(frame),NSStringFromCGRect(frame1));
    frame1.origin = CGPointZero;
    NSLog(@"layer bounds before:%@ after:%@",NSStringFromCGRect(bounds),NSStringFromCGRect(bounds1));
    
    NSLog(@"set frame :%@",NSStringFromCGRect(frame1));
    v.frame = frame1;
    
    NSLog(@"view frame:%@ bounds:%@",NSStringFromCGRect(v.frame),NSStringFromCGRect(v.bounds));
    NSLog(@"view transform:%@",NSStringFromCGAffineTransform(v.transform));
    
    CGAffineTransform t = CGAffineTransformInvert(v.transform);
    CGRect originFrame = CGRectApplyAffineTransform(frame1, t);
    NSLog(@"origin frame:%@",NSStringFromCGRect(originFrame));
    
    CGAffineTransform ii = CGAffineTransformInvert(CGAffineTransformIdentity);
    CGRect ff = CGRectApplyAffineTransform(originFrame, ii);
    
    NSLog(@"debug frame:%@",NSStringFromCGRect(ff));

    
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(0, 0, 100, 100);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer];
//    
//    NSLog(@"layer before: frame:%@ position:%@ bounds:%@",NSStringFromCGRect(layer.frame),NSStringFromCGPoint(layer.position),NSStringFromCGRect(layer.bounds));
//    layer.affineTransform = CGAffineTransformMakeScale(0.5, 0.5);
//    
//    NSLog(@"layer after: frame:%@ position:%@ bounds:%@",NSStringFromCGRect(layer.frame),NSStringFromCGPoint(layer.position),NSStringFromCGRect(layer.bounds));
//    CGRect r1 = layer.frame;
//    r1.origin = CGPointZero;
//    layer.frame = r1;
//    NSLog(@"layer set frame after: frame:%@ position:%@ bounds:%@",NSStringFromCGRect(layer.frame),NSStringFromCGPoint(layer.position),NSStringFromCGRect(layer.bounds));


    
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
