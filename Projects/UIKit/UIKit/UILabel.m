//
//  UILable.m
//  UIKit
//
//  Created by Chen Yonghui on 12/8/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UILabel.h"
#import <UIKit/UIGraphics.h>
#import "NSStringDrawing.h"
#import "UIColor.h"

#import <CoreText/CoreText.h>

@implementation UILabel
- (void)drawTextInRect:(CGRect)rect
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [_text drawInRect:rect withAttributes:@{kCTForegroundColorAttributeName: self.textColor}];
//    [_text drawInRect:rect withFont:_font lineBreakMode:_lineBreakMode alignment:_textAlignment];
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorRef color = CGColorCreateGenericRGB(0, 1, 0, 1);
    CGContextSetFillColorWithColor(ctx, color);
    CGColorRelease(color);

    CGContextFillRect(ctx, rect);
    [self.textColor set];
    
    if (_text.length > 0) {
        CGContextSaveGState(UIGraphicsGetCurrentContext());
        [self drawTextInRect:rect];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    }
}


@end
