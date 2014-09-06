//
//  TNCTView.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCTView.h"
#import <CoreText/CoreText.h>

@implementation TNCTView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self.attributedString drawInRect:self.bounds];
    return;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    
    // Font
    CGFloat fontSize = 20;
    
    NSDictionary *fontAttributes = [self fontAttributes];
    CTFontDescriptorRef fontDescRef = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)(fontAttributes));
    CTFontRef fontRef = CTFontCreateWithFontDescriptor(fontDescRef, fontSize, NULL);
    NSLog(@"fontDesc:%@",fontDescRef);
    
    NSString *actualFamilyName = (__bridge_transfer id)(CTFontCopyFamilyName(fontRef));
    NSString *expectFamilyName = fontAttributes[(NSString *)kCTFontFamilyNameAttribute];

    NSLog(@"font:%@",fontRef);
    NSLog(@"actualFamilyName:%@ expectFamilyName:%@",actualFamilyName,expectFamilyName);
    
    NSAttributedString *att = self.attributedString;

    
    CGFloat width = self.bounds.size.width;
    width = 648;
    
    
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(att));
    
    // on android Next Book:104
    // correct shoule be: 53?
    CFIndex textCount = CTTypesetterSuggestLineBreak(typesetter, 0, width);
    NSLog(@"suggest at idx:0 with width:%f result:%d",width,textCount);
    
    
    
    NSLog(@"%@",[[att attributedSubstringFromRange:NSMakeRange(0, textCount)] string]);
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(0, textCount));
    
    //    [[UIColor redColor] set];
    
    //    CGContextSetTextPosition(ctx, 0, 50);
    //    CTLineDraw(line, ctx);
    
    //    textCount = CTTypesetterSuggestLineBreak(typesetter, 0, width/2);
    //    NSLog(@"suggest at idx:0 with width:%f result:%d",width/2,textCount);
    //    NSLog(@"%@",[[att attributedSubstringFromRange:NSMakeRange(0, textCount)] string]);
    //
    //    textCount = CTTypesetterSuggestLineBreak(typesetter, 50, width);
    //    NSLog(@"suggest at idx:50 with width:%f result:%d",width,textCount);
    //    NSLog(@"%@",[[att attributedSubstringFromRange:NSMakeRange(50, textCount)] string]);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(att));
    CGRect bounds = self.bounds;
    bounds.origin.y = -300;
    bounds.size.width = width;
    
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(frame, ctx);

}

- (NSDictionary *)fontAttributes
{
    return @{
             (NSString *)kCTFontFamilyNameAttribute : @"Helvetica",
             };
}

@end
