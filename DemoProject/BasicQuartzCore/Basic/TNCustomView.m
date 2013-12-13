//
//  TNCustomView.m
//  BasicCairo
//
//  Created by Chen Yonghui on 12/10/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCustomView.h"

@implementation TNCustomView
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorRef gb = CGColorCreateGenericRGB(0, 1, 1, 1);
    CGContextSetFillColorWithColor(ctx, gb);
    CGContextFillRect(ctx, rect);
    
    CGColorRef red = CGColorCreateGenericRGB(1, 0, 0, 1);
    CGContextSetStrokeColorWithColor(ctx, red);
    
    CGContextMoveToPoint(ctx, 10, 0);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 100, 0);
    CGContextAddLineToPoint(ctx, 10, 100);
    CGContextStrokePath(ctx);
    
}
@end
