//
//  NBRadialGradientLayer.m
//  NextBook
//
//  Created by Chen Yonghui on 5/22/13.
//  Copyright (c) 2013 Shanghai TinyNetwork. All rights reserved.
//

#import "NBRadialGradientLayer.h"

@implementation NBRadialGradientLayer

- (void)drawInContext:(CGContextRef)ctx
{
//    [[UIColor redColor] setFill];
//    CGContextFillRect(ctx, self.bounds);
    
    CGFloat * locations = malloc(self.locations.count * sizeof(CGFloat));
    for (int i = 0; i < self.locations.count; ++i) {
        locations[i] = [self.locations[i] floatValue];
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientDrawingOptions options = 0;
    options |= kCGGradientDrawsBeforeStartLocation;
    options |= kCGGradientDrawsAfterEndLocation;
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.colors, locations);
    
    CGPoint startPoint = CGPointMake(self.natureSize.width * self.startPoint.x, self.natureSize.height * self.startPoint.y);
    CGPoint endPoint = CGPointMake(self.natureSize.width * self.endPoint.x, self.natureSize.height * self.endPoint.y);
    
    CGFloat r = MIN(self.natureSize.width, self.natureSize.height) * self.endRadius;
    
    if (self.natureSize.width != 0.0f && self.natureSize.height != 0.0f) {
        CGContextScaleCTM(ctx, self.frame.size.width / self.natureSize.width, self.frame.size.height / self.natureSize.height);
    }

    CGContextDrawRadialGradient(ctx, gradient, startPoint, 0, endPoint, r, options);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    free(locations);
}
@end
