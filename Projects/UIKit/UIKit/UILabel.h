//
//  UILable.h
//  UIKit
//
//  Created by Chen Yonghui on 12/8/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIView.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIKitDefines.h>

@class UIColor, UIFont;

@interface UILabel : UIView
@property(nonatomic,copy)   NSString           *text;
@property(nonatomic,retain) UIFont             *font;
@property(nonatomic,retain) UIColor            *textColor;
@property(nonatomic,retain) UIColor            *shadowColor;
@property(nonatomic)        CGSize             shadowOffset;
@property(nonatomic)        NSTextAlignment    textAlignment;
@property(nonatomic)        NSLineBreakMode    lineBreakMode;

@property(nonatomic,copy)   NSAttributedString *attributedText;

@property(nonatomic,retain)               UIColor *highlightedTextColor;
@property(nonatomic,getter=isHighlighted) BOOL     highlighted;

@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property(nonatomic,getter=isEnabled)                BOOL enabled;


@property(nonatomic) NSInteger numberOfLines;

@property(nonatomic) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic) UIBaselineAdjustment baselineAdjustment;
@property(nonatomic) CGFloat minimumScaleFactor;

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines;
- (void)drawTextInRect:(CGRect)rect;

@property(nonatomic) CGFloat preferredMaxLayoutWidth;


#pragma mark - DEPRECATED
@property(nonatomic) CGFloat minimumFontSize;// NS_DEPRECATED_IOS(2_0, 6_0);
@property(nonatomic) BOOL adjustsLetterSpacingToFitWidth; //NS_DEPRECATED_IOS(6_0,7_0);


@end
