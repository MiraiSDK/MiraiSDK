//
//  NSStringDrawing.m
//  UIKit
//
//  Created by Chen Yonghui on 12/8/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "NSStringDrawing.h"
#import "UIGraphics.h"
#import <CoreText/CoreText.h>

@implementation NSStringDrawingContext

@end

@implementation NSString(NSStringDrawing)
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs
{
    return CGSizeZero;
}

- (void)drawAtPoint:(CGPoint)point withAttributes:(NSDictionary *)attrs
{
    
}

- (void)drawInRect:(CGRect)rect withAttributes:(NSDictionary *)attrs
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSLog(@"get context");

    CGColorRef blue = CGColorCreateGenericRGB(0, 0, 1, 1);
    CTFontRef font = CTFontCreateWithName(@"Arial", 16, NULL);
    NSDictionary *dict = @{kCTForegroundColorAttributeName:blue,kCTFontAttributeName:font};
    NSAttributedString *att =[[NSAttributedString alloc] initWithString:self attributes:dict];
    NSLog(@"%@, length:%d",att,[att length]);

    CTFramesetterRef frameseter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(att));
    NSLog(@"framesetter:%@",frameseter);

    CGMutablePathRef path = CGPathCreateMutable();
    NSLog(@"path:%@",path);
    CGPathAddRect(path, NULL, CGRectMake(0, 0, 700, 700));
    NSLog(@"addRect");

    CTFrameRef frame = CTFramesetterCreateFrame(frameseter, CFRangeMake(0, 0), path, NULL);
    NSLog(@"frame:%@",frameseter);
    CGContextSetStrokeColorWithColor(ctx, blue);
    CTFrameDraw(frame, ctx);
    NSLog(@"draw");

    
    CGPathRelease(path);
    NSLog(@"releasePath");
    

    
    
    
    

}
@end

