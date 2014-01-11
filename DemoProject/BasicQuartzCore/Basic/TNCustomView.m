//
//  TNCustomView.m
//  BasicCairo
//
//  Created by Chen Yonghui on 12/10/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCustomView.h"
#import <CoreText/CoreText.h>

@implementation TNCustomView {
    NSAttributedString *_attributedString;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _attributedString = [[NSAttributedString alloc] initWithString:@"Hello Miku" attributes:[self attributes]];

    }
    return self;
}

- (NSDictionary *)attributes
{
    CGColorRef redColor = CGColorCreateGenericRGB(1, 0, 0, 1);
    CGFontRef font = CGFontCreateWithFontName(@"Arial");
    return @{
             (__bridge NSString *)kCTForegroundColorAttributeName:(id)redColor,
             //(__bridge NSString *)kCTFontAttributeName:font
             };
}


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
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(_attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CTFrameDraw(frame, ctx);
    
}
@end
