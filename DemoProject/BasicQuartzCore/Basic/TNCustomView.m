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
    CGFontRef font = CGFontCreateWithFontName(@"Roboto");
    return @{
             (__bridge NSString *)kCTForegroundColorAttributeName:(id)redColor,
             //(__bridge NSString *)kCTFontAttributeName:font
             };
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor cyanColor] setFill];
    CGContextFillRect(ctx, rect);
    
    [[UIColor redColor] set];
    
//    CGContextMoveToPoint(ctx, 10, 0);
//    CGContextAddLineToPoint(ctx, 100, 100);
//    CGContextAddLineToPoint(ctx, 100, 0);
//    CGContextAddLineToPoint(ctx, 10, 100);
//    CGContextStrokePath(ctx);
    
//    NSLog(@"will create font:Robote");
//    CGAffineTransform t = {1,0,0,1,0,0};
//    CGContextSetTextMatrix(ctx, t);
//    CGFontRef f = CGFontCreateWithFontName(@"Roboto");
//    CGContextSelectFont(ctx, "Roboto", 32, kCGEncodingMacRoman);
//    CGContextShowTextAtPoint(ctx, 0, 0, "HelloWorld", 10);
//    if (!f) {
//        NSLog(@"empty font");
//    }
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(_attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CTFrameDraw(frame, ctx);
    
}
@end
