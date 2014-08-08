//
//  TNShapeLayerTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/8/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNShapeLayerTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TNShapeLayerTestViewController ()

@end

@implementation TNShapeLayerTestViewController

+ (NSString *)testName
{
    return @"Shape Layer Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100) cornerRadius:10];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(50, 50, 200, 200);
    shape.fillColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;
    CGPathRef pathCG = path.CGPath;
    shape.borderWidth = 1;
    shape.borderColor = [UIColor redColor].CGColor;
    shape.path = CGPathRetain(pathCG);
    [shape setNeedsDisplay];
    [self.view.layer addSublayer:shape];
    
    CALayer *l = [CALayer layer];
    l.frame = CGRectMake(50, 260, 200, 200);
    l.borderWidth = 2;
    l.borderColor = [UIColor greenColor].CGColor;
//    [l setNeedsDisplay];
    [self.view.layer addSublayer:l];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
