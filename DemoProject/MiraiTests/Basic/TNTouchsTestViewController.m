//
//  TNTouchsTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTouchsTestViewController.h"

@interface TNTouchsTestViewController ()

@end

@implementation TNTouchsTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Touches Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesBegan:%@ event:<%@: %p> timestamp: %.2f",touches,event.class,event,event.timestamp);
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:touch.view];
    NSLog(@"location in view:<%p %@> location:%@",touch.view,touch.view.class,NSStringFromCGPoint(p));

    CGPoint wp = [touch locationInView:touch.view.window];
    NSLog(@"location in view:<%p %@> location:%@",touch.view.window,touch.view.window.class,NSStringFromCGPoint(wp));
    
    CGPoint pp = [self.view convertPoint:CGPointZero toView:nil];
    CGRect rect = [self.view convertRect:CGRectMake(0, 0, 100, 100) toView:nil];
    NSLog(@"view zero point to window:%@",NSStringFromCGPoint(pp));
    NSLog(@"view {0,0}{100,100} to window:%@",NSStringFromCGRect(rect));
    
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesMoved:%@ event:<%@: %p> timestamp: %.2f",touches,event.class,event,event.timestamp);
//}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesEnded:%@ event:<%@: %p> timestamp: %.2f",touches,event.class,event,event.timestamp);
//}

@end
