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
@property(nonatomic,copy)   NSString           *text;            // default is nil
@property(nonatomic,retain) UIFont             *font;            // default is nil (system font 17 plain)
@property(nonatomic,retain) UIColor            *textColor;       // default is nil (text draws black)
@property(nonatomic,retain) UIColor            *shadowColor;     // default is nil (no shadow)
@property(nonatomic)        CGSize             shadowOffset;    // default is CGSizeMake(0, -1) -- a top shadow
//@property(nonatomic)        NSTextAlignment    textAlignment;
//@property(nonatomic)        NSLineBreakMode    lineBreakMode;

// the underlying attributed string drawn by the label, if set, the label ignores the properties above.
//@property(nonatomic,copy)   NSAttributedString *attributedText NS_AVAILABLE_IOS(6_0);  // default is nil

@property(nonatomic,retain)               UIColor *highlightedTextColor; // default is nil
@property(nonatomic,getter=isHighlighted) BOOL     highlighted;          // default is NO
@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;  // default is NO
@property(nonatomic,getter=isEnabled)                BOOL enabled;                 // default is YES. changes how the label is drawn
@property(nonatomic) NSInteger numberOfLines;

//@property(nonatomic) BOOL adjustsFontSizeToFitWidth;         // default is NO
//@property(nonatomic) BOOL adjustsLetterSpacingToFitWidth NS_DEPRECATED_IOS(6_0,7_0); // deprecated - hand tune by using NSKernAttributeName to affect tracking
//@property(nonatomic) CGFloat minimumFontSize NS_DEPRECATED_IOS(2_0, 6_0); // NOTE: deprecated - use minimumScaleFactor. default is 0.0
//@property(nonatomic) UIBaselineAdjustment baselineAdjustment; // default is UIBaselineAdjustmentAlignBaselines
//@property(nonatomic) CGFloat minimumScaleFactor NS_AVAILABLE_IOS(6_0); // default is 0.0

// override points. can adjust rect before calling super.
// label has default content mode of UIViewContentModeRedraw

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines;
- (void)drawTextInRect:(CGRect)rect;


// Support for constraint-based layout (auto layout)
// If nonzero, this is used when determining -intrinsicContentSize for multiline labels
//@property(nonatomic) CGFloat preferredMaxLayoutWidth NS_AVAILABLE_IOS(6_0);

@end
