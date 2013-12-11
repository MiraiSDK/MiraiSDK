//
//  UIGraphics.m
//  UIKit
//
//  Created by Chen Yonghui on 12/7/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIGraphics.h"

static NSMutableArray* contextStack()
{
    static NSMutableArray *_contextStack;
    if (!_contextStack) {
        _contextStack = [NSMutableArray array];
    }
    return _contextStack;
}

CGContextRef UIGraphicsGetCurrentContext(void)
{
    return [contextStack() lastObject];
}

void UIGraphicsPushContext(CGContextRef context)
{
    [contextStack() addObject:context];
}

void UIGraphicsPopContext(void)
{
    [contextStack() removeLastObject];
}

#pragma mark -
static NSMutableArray *imageContextStatck;
void     UIGraphicsBeginImageContext(CGSize size)
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
}
void     UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
{
    if (scale == 0.f) {
        scale = 1;
    }
    
    const size_t width = size.width * scale;
    const size_t height = size.height * scale;

    if (width > 0 && height > 0) {
        if (!imageContextStatck) {
            imageContextStatck = [NSMutableArray array];
        }
        
        [imageContextStatck addObject:@(scale)];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef ctx = CGBitmapContextCreate(NULL, width, height, 8, 4*width, colorSpace, (opaque? kCGImageAlphaNoneSkipFirst : kCGImageAlphaPremultipliedFirst));
        CGContextConcatCTM(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, height));
        CGContextScaleCTM(ctx, scale, scale);
        CGColorSpaceRelease(colorSpace);
        UIGraphicsPushContext(ctx);
        CGContextRelease(ctx);
    } else {
        NSLog(@"Create image context failed, size incorrect:%.2f,%.2f",size.width,size.height);
    }

}

UIImage* UIGraphicsGetImageFromCurrentImageContext(void)
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    return cgImage;
}

void     UIGraphicsEndImageContext(void)
{
    if ([imageContextStatck lastObject]) {
        [imageContextStatck removeLastObject];
        UIGraphicsPopContext();
    }
}

