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
    NSLog(@"touchesBegan:%@ event:<%@: %p> timestamp: %.2f",touches,event.class,event,event.timestamp);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved:%@ event:<%@: %p> timestamp: %.2f",touches,event.class,event,event.timestamp);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded:%@ event:<%@: %p> timestamp: %.2f",touches,event.class,event,event.timestamp);
}

@end
