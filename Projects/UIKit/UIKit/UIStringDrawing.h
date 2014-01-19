//
//  UIStringDrawing.h
//  UIKit
//
//  Created by Chen Yonghui on 12/8/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/NSParagraphStyle.h>
#import <UIKit/NSText.h>

UIKIT_EXTERN NSString *const UITextAttributeFont;
UIKIT_EXTERN NSString *const UITextAttributeTextColor;
UIKIT_EXTERN NSString *const UITextAttributeTextShadowColor;
UIKIT_EXTERN NSString *const UITextAttributeTextShadowOffset;

typedef NS_ENUM(NSInteger, UILineBreakMode) {
    UILineBreakModeWordWrap = 0,            // Wrap at word boundaries
    UILineBreakModeCharacterWrap,           // Wrap at character boundaries
    UILineBreakModeClip,                    // Simply clip when it hits the end of the rect
    UILineBreakModeHeadTruncation,          // Truncate at head of line: "...wxyz". Will truncate multiline text on first line
    UILineBreakModeTailTruncation,          // Truncate at tail of line: "abcd...". Will truncate multiline text on last line
    UILineBreakModeMiddleTruncation,        // Truncate middle of line:  "ab...yz". Will truncate multiline text in the middle
};

// Deprecated: use NSTextAlignment enum in UIKit/NSText.h
typedef NS_ENUM(NSInteger, UITextAlignment) {
    UITextAlignmentLeft = 0,
    UITextAlignmentCenter,
    UITextAlignmentRight,                   // could add justified in future
};

typedef NS_ENUM(NSInteger, UIBaselineAdjustment) {
    UIBaselineAdjustmentAlignBaselines = 0, // default. used when shrinking text to position based on the original baseline
    UIBaselineAdjustmentAlignCenters,
    UIBaselineAdjustmentNone,
};

@class UIFont;

@interface NSString(UIStringDrawing)
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

// Single line, no wrapping. Truncation based on the NSLineBreakMode.
- (CGSize)drawAtPoint:(CGPoint)point withFont:(UIFont *)font;
- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

// Wrapping to fit horizontal and vertical size.
- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font;
- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

- (CGSize)sizeWithFont:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width withFont:(UIFont *)font fontSize:(CGFloat)fontSize lineBreakMode:(NSLineBreakMode)lineBreakMode baselineAdjustment:(UIBaselineAdjustment)baselineAdjustment;

- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width withFont:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize lineBreakMode:(NSLineBreakMode)lineBreakMode baselineAdjustment:(UIBaselineAdjustment)baselineAdjustment;

@end
