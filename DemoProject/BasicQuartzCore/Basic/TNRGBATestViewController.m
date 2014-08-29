//
//  TNRGBATestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/29/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNRGBATestViewController.h"

@interface RGBAView : UIView
@end
@implementation RGBAView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[UIColor whiteColor] setFill];
    CGContextFillRect(ctx, self.bounds);
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat d = MIN(width, height);
    
    CGFloat gap = d/10;
    CGFloat cellLength = (d - 3 * gap)/2;
    
    [[UIColor redColor] setFill];
    CGContextFillRect(ctx, CGRectMake(gap, gap, cellLength, cellLength));
    
    [[UIColor greenColor] setFill];
    CGContextFillRect(ctx, CGRectMake(gap + cellLength + gap, gap, cellLength, cellLength));
    
    [[UIColor blueColor] setFill];
    CGContextFillRect(ctx, CGRectMake(gap, gap + cellLength + gap, cellLength, cellLength));
    
    [[UIColor clearColor] setFill];
    CGContextClearRect(ctx, CGRectMake(gap + cellLength + gap, gap + cellLength + gap, cellLength, cellLength));
}

@end

@interface TNRGBATestViewController ()

@end

@implementation TNRGBATestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"RGBA Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    RGBAView *v = [[RGBAView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    v.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:v];
    
    
}


@end
