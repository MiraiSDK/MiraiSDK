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
    [self setterTest];
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
    NSLog(@"keypath set value test");
    CALayer *l = [CALayer layer];
    
    CGPoint position = CGPointMake(12, 13);
    [l setValue:@(position.x) forKeyPath:@"position.x"];
    [l setValue:@(position.y) forKeyPath:@"position.y"];
    
    if (! CGPointEqualToPoint(l.position, position) ) {
        NSLog(@"position set test failed");
    }
    
    CGSize shadowOffset = CGSizeMake(11, 22);
    [l setValue:@(shadowOffset.width) forKeyPath:@"shadowOffset.width"];
    [l setValue:@(shadowOffset.height) forKeyPath:@"shadowOffset.height"];
    if (! CGSizeEqualToSize(l.shadowOffset, shadowOffset)) {
        NSLog(@"shadowoffset set test failed");
    }
    
    CGRect rect1 = CGRectMake(1, 2, 3, 4);
    [l setValue:@(rect1.origin.x) forKeyPath:@"bounds.origin.x"];
    [l setValue:@(rect1.origin.y) forKeyPath:@"bounds.origin.y"];
    [l setValue:@(rect1.size.width) forKeyPath:@"bounds.size.width"];
    [l setValue:@(rect1.size.height) forKeyPath:@"bounds.size.height"];
    if (! CGRectEqualToRect(l.bounds, rect1)) {
        NSLog(@"bounds set test failed");
    }
    l.bounds = CGRectZero;
    
    [l setValue:[NSValue valueWithCGPoint:rect1.origin] forKeyPath:@"bounds.origin"];
    [l setValue:[NSValue valueWithCGSize:rect1.size] forKeyPath:@"bounds.size"];
    if (! CGRectEqualToRect(l.bounds, rect1)) {
        NSLog(@"bounds origin&size set test failed");
    }
    
    CGFloat scaleX = 2;
    CGFloat scaleY = 3;
    CGFloat scaleZ = 4;
    
    [l setValue:@(scaleX) forKeyPath:@"transform.scale.x"];
    [l setValue:@(scaleY) forKeyPath:@"transform.scale.y"];
    [l setValue:@(scaleZ) forKeyPath:@"transform.scale.z"];
    
    CGFloat translationX = 5;
    CGFloat translationY = 6;
    CGFloat translationZ = 7;
    
    [l setValue:@(translationX) forKeyPath:@"transform.translation.x"];
    [l setValue:@(translationY) forKeyPath:@"transform.translation.y"];
    [l setValue:@(translationZ) forKeyPath:@"transform.translation.z"];
    
    CATransform3D t = l.transform;
    
    if (! (t.m11 == scaleX &&
           t.m22 == scaleY &&
           t.m33 == scaleZ &&
           t.m41 == translationX &&
           t.m42 == translationY &&
           t.m43 == translationZ)) {
        NSLog(@"transform test 1 failed");
        NSLog(@"expected scaleX:%f value:%f",scaleX,t.m11);
        NSLog(@"expected scaleY:%f value:%f",scaleY,t.m22);
        NSLog(@"expected scaleZ:%f value:%f",scaleZ,t.m33);
        
        NSLog(@"expected translationX:%f value:%f",translationX,t.m41);
        NSLog(@"expected translationY:%f value:%f",translationY,t.m42);
        NSLog(@"expected translationZ:%f value:%f",translationZ,t.m43);
    }
    
    CGSize translation = CGSizeMake(8, 9);
    [l setValue:[NSValue valueWithCGSize:translation] forKeyPath:@"transform.translation"];
    if (l.transform.m41 != translation.width ||
        l.transform.m42 != translation.height) {
        NSLog(@"transform.translation test failed");
    }
    
    l.transform = CATransform3DIdentity;
    
    CGFloat rotationX = 0.1;
    CGFloat rotationY = 0.2;
    CGFloat rotationZ = 0.3;
    
    [l setValue:@(rotationX) forKeyPath:@"transform.rotation.x"];
    [l setValue:@(rotationY) forKeyPath:@"transform.rotation.y"];
    [l setValue:@(rotationZ) forKeyPath:@"transform.rotation.z"];
    
    CGFloat rotationX1 = [[l valueForKeyPath:@"transform.rotation.x"] floatValue];
    CGFloat rotationY1 = [[l valueForKeyPath:@"transform.rotation.y"] floatValue];
    CGFloat rotationZ1 = [[l valueForKeyPath:@"transform.rotation.z"] floatValue];
    if (rotationX != rotationX1 ||
        rotationY != rotationY1 ||
        rotationZ != rotationZ1) {
        NSLog(@"rotationX:%f value:%f",rotationX,rotationX1);
        NSLog(@"rotationY:%f value:%f",rotationY,rotationY1);
        NSLog(@"rotationZ:%f value:%f",rotationZ,rotationZ1);
    }

    CATransform3D t2 = l.transform;
    
    CGFloat rotation = 0.4;
    [l setValue:@(rotation) forKeyPath:@"transform.rotation"];
    CGFloat rotation1 = [[l valueForKeyPath:@"transform.rotation"] floatValue];
    if (rotation != rotation1) {
        NSLog(@"rotation:%f value:%f",rotation,rotation1);
    }
    
    CATransform3D t3 = l.transform;
    
    NSLog(@"done");
    
}
@end
