//
//  TNLayerKeyPathTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/6/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLayerKeyPathTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation TNLayerKeyPathTestViewController
+ (NSString *)testName
{
   return @"Layer KeyPath";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    
    [self getterTest];
}

- (void)testNumberedKeyPath:(NSString *)keyPath expectedValue:(NSNumber *)expectedValue forLayer:(CALayer *)l
{
    id value = [l valueForKeyPath:keyPath];
    double diff = [value doubleValue] - [expectedValue doubleValue];
    BOOL numberEqual = ABS(diff) < 0.0000001 ;
    NSString *reason = [NSString stringWithFormat:@"test valueForKeyPath:%@ Failed; expetced:%@ value:%@",keyPath,expectedValue,value];
    if (!numberEqual) {
        NSLog(@"%@",reason);
    }
//    NSAssert(numberEqual, reason);
}

- (void)testSizedKeyPath:(NSString *)keyPath expectedValue:(CGSize)expectedValue forLayer:(CALayer *)l
{
    id value = [l valueForKeyPath:keyPath];
    CGSize size = [value CGSizeValue];
    NSString *reason = [NSString stringWithFormat:@"test valueForKeyPath:%@ Failed; expetced:%@ value:%@",keyPath,NSStringFromCGSize(expectedValue),NSStringFromCGSize(size)];
    if (!CGSizeEqualToSize(size, expectedValue)) {
        NSLog(@"%@",reason);
    }

    //    NSAssert(CGSizeEqualToSize(size, expectedValue), reason);
}

- (void)testPointedKeyPath:(NSString *)keyPath expectedValue:(CGPoint)expectedValue forLayer:(CALayer *)l
{
    id value = [l valueForKeyPath:keyPath];
    CGPoint point = [value CGPointValue];
    NSString *reason = [NSString stringWithFormat:@"test valueForKeyPath:%@ Failed; expetced:%@ value:%@",keyPath,NSStringFromCGPoint(expectedValue),NSStringFromCGPoint(point)];
    if (!CGPointEqualToPoint(point, expectedValue)) {
        NSLog(@"%@",reason);
    }

    //    NSAssert(CGPointEqualToPoint(point, expectedValue), reason);
}

- (void)getterTest
{
    CALayer *l = [CALayer layer];
    CATransform3D t = CATransform3DIdentity;
    t = CATransform3DRotate(t, M_PI_4, 1, 0, 0);
    t = CATransform3DRotate(t, M_PI_4, 0, 1, 0);
    t = CATransform3DRotate(t, M_PI_4, 0, 0, 1);
    t = CATransform3DScale(t, 2, 3, 4);
    t = CATransform3DTranslate(t, 10, 20, 30);
    l.transform = t;
    
    l.bounds = CGRectMake(0, 0, 100, 150);
    l.position = CGPointMake(90, 120);
    l.shadowOffset = CGSizeMake(2, -2);
    
    
    [self testSizedKeyPath:@"transform.translation" expectedValue:CGSizeMake(64.85281374238569, -34.14213562373094) forLayer:l];
    [self testNumberedKeyPath:@"transform.translation.x" expectedValue:@(64.85281374238569) forLayer:l];
    [self testNumberedKeyPath:@"transform.translation.y" expectedValue:@(-34.14213562373094) forLayer:l];
    [self testNumberedKeyPath:@"transform.translation.z" expectedValue:@(114.142135623731) forLayer:l];
    
    [self testNumberedKeyPath:@"transform.scale" expectedValue:@(3) forLayer:l];
    [self testNumberedKeyPath:@"transform.scale.x" expectedValue:@(2) forLayer:l];
    [self testNumberedKeyPath:@"transform.scale.y" expectedValue:@(3) forLayer:l];
    [self testNumberedKeyPath:@"transform.scale.z" expectedValue:@(4) forLayer:l];
    
    [self testNumberedKeyPath:@"transform.rotation" expectedValue:@(1.04089353704597) forLayer:l];
    [self testNumberedKeyPath:@"transform.rotation.x" expectedValue:@(1.04089353704597) forLayer:l];
    [self testNumberedKeyPath:@"transform.rotation.y" expectedValue:@(-0.1469751906635049) forLayer:l];
    [self testNumberedKeyPath:@"transform.rotation.z" expectedValue:@(1.04089353704597) forLayer:l];
    
    [self testNumberedKeyPath:@"position.x" expectedValue:@(l.position.x) forLayer:l];
    [self testNumberedKeyPath:@"position.y" expectedValue:@(l.position.y) forLayer:l];
    
    [self testNumberedKeyPath:@"shadowOffset.width" expectedValue:@(l.shadowOffset.width) forLayer:l];
    [self testNumberedKeyPath:@"shadowOffset.height" expectedValue:@(l.shadowOffset.height) forLayer:l];
    
    [self testPointedKeyPath:@"bounds.origin" expectedValue:l.bounds.origin forLayer:l];
    [self testNumberedKeyPath:@"bounds.origin.x" expectedValue:@(l.bounds.origin.x) forLayer:l];
    [self testNumberedKeyPath:@"bounds.origin.y" expectedValue:@(l.bounds.origin.y) forLayer:l];
    
    [self testSizedKeyPath:@"bounds.size" expectedValue:l.bounds.size forLayer:l];
    [self testNumberedKeyPath:@"bounds.size.width" expectedValue:@(l.bounds.size.width) forLayer:l];
    [self testNumberedKeyPath:@"bounds.size.height" expectedValue:@(l.bounds.size.height) forLayer:l];
}

- (void)setterTest
{
    
}
@end
