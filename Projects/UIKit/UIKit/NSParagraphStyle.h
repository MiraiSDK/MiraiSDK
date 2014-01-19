//
//  NSParagraphStyle.h
//  UIKit
//
//  Created by Chen Yonghui on 1/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/NSText.h>

// NSTextTab
UIKIT_EXTERN NSString *const NSTabColumnTerminatorsAttributeName;

@interface NSTextTab : NSObject <NSCopying, NSCoding>
- (id)initWithTextAlignment:(NSTextAlignment)alignment location:(CGFloat)loc options:(NSDictionary *)options;
+ (NSCharacterSet *)columnTerminatorsForLocale:(NSLocale *)aLocale;

@property(readonly) NSTextAlignment alignment;
@property(readonly) CGFloat location;
@property(readonly) NSDictionary *options;
@end

// NSParagraphStyle
typedef NS_ENUM(NSInteger, NSLineBreakMode) {		/* What to do with long lines */
    NSLineBreakByWordWrapping = 0,     	/* Wrap at word boundaries, default */
    NSLineBreakByCharWrapping,		/* Wrap at character boundaries */
    NSLineBreakByClipping,		/* Simply clip */
    NSLineBreakByTruncatingHead,	/* Truncate at head of line: "...wxyz" */
    NSLineBreakByTruncatingTail,	/* Truncate at tail of line: "abcd..." */
    NSLineBreakByTruncatingMiddle	/* Truncate middle of line:  "ab...yz" */
};


@interface NSParagraphStyle : NSObject <NSCopying, NSMutableCopying, NSCoding>
+ (NSParagraphStyle *)defaultParagraphStyle;

+ (NSWritingDirection)defaultWritingDirectionForLanguage:(NSString *)languageName;
@property(readonly) CGFloat lineSpacing;
@property(readonly) CGFloat paragraphSpacing;
@property(readonly) NSTextAlignment alignment;


@property(readonly) CGFloat headIndent;
@property(readonly) CGFloat tailIndent;
@property(readonly) CGFloat firstLineHeadIndent;

@property(readonly) CGFloat minimumLineHeight;
@property(readonly) CGFloat maximumLineHeight;

@property(readonly) NSLineBreakMode lineBreakMode;

@property(readonly) NSWritingDirection baseWritingDirection;

@property(readonly) CGFloat lineHeightMultiple;
@property(readonly) CGFloat paragraphSpacingBefore;

@property(readonly) float hyphenationFactor;

@property(readonly,copy,nonatomic) NSArray *tabStops;
@property(readonly,nonatomic) CGFloat defaultTabInterval;

@end

@interface NSMutableParagraphStyle : NSParagraphStyle

@property(readwrite) CGFloat lineSpacing;
@property(readwrite) CGFloat paragraphSpacing;
@property(readwrite) NSTextAlignment alignment;
@property(readwrite) CGFloat firstLineHeadIndent;
@property(readwrite) CGFloat headIndent;
@property(readwrite) CGFloat tailIndent;
@property(readwrite) NSLineBreakMode lineBreakMode;
@property(readwrite) CGFloat minimumLineHeight;
@property(readwrite) CGFloat maximumLineHeight;
@property(readwrite) NSWritingDirection baseWritingDirection;
@property(readwrite) CGFloat lineHeightMultiple;
@property(readwrite) CGFloat paragraphSpacingBefore;
@property(readwrite) float hyphenationFactor;
@property(readwrite,copy,nonatomic) NSArray *tabStops;
@property(readwrite,nonatomic) CGFloat defaultTabInterval;

@end
