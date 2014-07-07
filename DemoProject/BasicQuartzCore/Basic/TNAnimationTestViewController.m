//
//  TNAnimationTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAnimationTestViewController.h"

@interface TNAnimationTestViewController ()
@property (nonatomic, strong) CALayer *quadLayer;
@property (nonatomic, strong) UIView *quadView;
@property (nonatomic, strong) UIView *animationView;
@end
@implementation TNAnimationTestViewController
+ (NSString *)testName
{
    return @"Animation";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    //    CALayer *quad = [CALayer layer];
    //    quad.frame = CGRectMake(0, 0, 200, 200);
    //    quad.backgroundColor = [UIColor redColor].CGColor;
    //    [self.view.layer addSublayer:quad];
    //    self.quadLayer = quad;
    
    //    UIView *quadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    quadView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    //    [self.view addSubview:quadView];
    //    self.quadView = quadView;
    
    
    //    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    animationView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //    [self.view addSubview:animationView];
    //    self.animationView = animationView;
    
    //
    //    CALayer *subQuad = [CALayer layer];
    //    subQuad.frame = CGRectMake(50, 50, 100, 100);
    //    subQuad.backgroundColor = [UIColor greenColor].CGColor;
    //    [quad addSublayer:subQuad];
    //
    //    quad.shouldRasterize = YES;
    //
    //    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    //    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    //    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(600, 600)];
    //    ani.repeatCount = HUGE_VALF;
    //    ani.autoreverses = YES;
    //    ani.duration = 1;
    //    [quad addAnimation:ani forKey:@"move"];

}

- (void)testAnimation
{
    
    //    CGFloat width = CGRectGetWidth(self.view.bounds);
    //    CGFloat height = CGRectGetHeight(self.view.bounds);
    //
    //    CGFloat randomX = arc4random()%(NSInteger)width;
    //    CGFloat randomY = arc4random()%(NSInteger)height;
    //
    //    CGPoint randomPoint = CGPointMake(randomX, randomY);
    //    CGPoint prevPoint = self.quadView.center;
    
    //    NSLog(@"move to point:%@",NSStringFromCGPoint(randomPoint));
    
    //    [UIView animateWithDuration:5 animations:^{
    //        self.animationView.center = randomPoint;
    //    }];
    //
    //    self.quadLayer.position = randomPoint;
    
    //    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    //    ani.toValue = [NSValue valueWithCGPoint:randomPoint];
    //    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    ani.duration = 5;
    //    [self.quadView.layer addAnimation:ani forKey:@"Move"];
    //
    //    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"position"];
    //    ani1.toValue = [NSValue valueWithCGPoint:randomPoint];
    //    ani1.duration = 5;
    //    [self.quadLayer addAnimation:ani1 forKey:@"Move"];
    
    //NSLog(@"ani:%@",ani);
    //NSLog(@"ani1:%@",ani1);
    //    NSLog(@"view animations:%@",self.animationView.layer);
    
    
    //    CGPoint originCenter = CGPointMake(CGRectGetMidX(self.view.bounds),
    //                                       CGRectGetMidY(self.view.bounds));
    //    CGPoint center = self.quadView.center;
    //    if (CGPointEqualToPoint(originCenter, center)) {
    //        center.x += 200;
    //        center.y += 200;
    //    } else {
    //        center = originCenter;
    //    }
    //    [UIView animateWithDuration:5 animations:^{
    //        self.quadView.center = center;
    //    }];
    //
    //    self.quadLayer.position = center;

}
@end
