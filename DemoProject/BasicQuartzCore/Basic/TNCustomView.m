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
        _attributedString = [[NSAttributedString alloc] initWithString:@"I am the bone of my sword\nSteel is my body and fire is my blood\nI have created over a thousand blades\nUnaware of loss, Nor aware of gain\nWithstood pain to create weapons, waiting for one’s arrival\nI have no regrets. This is the only path \nMy whole life was unlimited blade works" attributes:[self attributes]];

    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (NSDictionary *)attributes
{
#ifdef ANDROID
    CGColorRef redColor = CGColorCreateGenericRGB(1, 0, 0, 1);
    CGFontRef font = CGFontCreateWithFontName(@"Roboto");
    return @{
             (__bridge NSString *)kCTForegroundColorAttributeName:(id)redColor,
             //(__bridge NSString *)kCTFontAttributeName:font
             };
#else
    CGColorRef redColor = CGColorRetain([UIColor redColor].CGColor);
    return @{
             (__bridge NSString *)kCTForegroundColorAttributeName:(__bridge id)redColor,
             };
#endif
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor cyanColor] setFill];
    CGContextFillRect(ctx, rect);
    
    [[UIColor redColor] set];
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 100, 0);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 0, 100);
    CGContextStrokePath(ctx);
    
//    NSLog(@"will create font:Robote");
//    CGAffineTransform t = {1,0,0,1,0,0};
//    CGContextSetTextMatrix(ctx, t);
//    CGFontRef f = CGFontCreateWithFontName(@"Roboto");
//    CGContextSelectFont(ctx, "Roboto", 32, kCGEncodingMacRoman);
//    CGContextShowTextAtPoint(ctx, 0, 0, "HelloWorld", 10);
//    if (!f) {
//        NSLog(@"empty font");
//    }
    
    CGAffineTransform t = CGContextGetTextMatrix(ctx);
    
    NSLog(@"origin text matrix:%@",NSStringFromCGAffineTransform(t));
    NSLog(@"will set text matrix:%@",NSStringFromCGAffineTransform(CGAffineTransformIdentity));
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGAffineTransform t1 = CGContextGetTextMatrix(ctx);
    NSLog(@"new text matrix:%@",NSStringFromCGAffineTransform(t1));
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attributedString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
//    CTFrameDraw(frame, ctx);
    
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef) _attributedString);
    
    CFIndex pos = 0;
    CGFloat y = 0;
    NSInteger lineIdx = 0;
    CFIndex length = _attributedString.length;
    while (pos < length) {
//        if (lineIdx >1) {
//            break;
//        }
        CFIndex textCount = CTTypesetterSuggestLineBreak(typesetter, pos, self.bounds.size.width);

        NSString *str = [_attributedString attributedSubstringFromRange:NSMakeRange(pos, textCount)].string;
        NSLog(@"line break, range:%@ str:%@",NSStringFromRange(NSMakeRange(pos, textCount)), str);

        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(pos, textCount));
        
        
        CGContextSetTextPosition(ctx, 0, y);
        CTLineDraw(line, ctx);
        
        pos += textCount;
#if ANDROID
        y += 40;
#else
        y += 20;
#endif
        lineIdx ++;
    }
    
}
@end
