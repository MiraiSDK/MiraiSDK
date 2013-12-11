//
//  NSStringDrawing.h
//  UIKit
//
//  Created by Chen Yonghui on 12/8/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
//#import <UIKit/NSAttributedString.h>
#import <UIKit/UIKitDefines.h>


@interface NSStringDrawingContext : NSObject
@property(nonatomic) CGFloat minimumScaleFactor;
@property(nonatomic, readonly) CGFloat actualScaleFactor;
@property(nonatomic, readonly) CGRect totalBounds;

//@property(nonatomic) CGFloat minimumTrackingAdjustment NS_DEPRECATED_IOS(6_0,7_0);
//@property(nonatomic, readonly) CGFloat actualTrackingAdjustment NS_DEPRECATED_IOS(6_0,7_0);
@end

@interface NSString(NSStringDrawing)
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs;
- (void)drawAtPoint:(CGPoint)point withAttributes:(NSDictionary *)attrs;
- (void)drawInRect:(CGRect)rect withAttributes:(NSDictionary *)attrs;
@end

//@interface NSAttributedString(NSStringDrawing)
//- (CGSize)size NS_AVAILABLE_IOS(6_0);
//- (void)drawAtPoint:(CGPoint)point NS_AVAILABLE_IOS(6_0);
//- (void)drawInRect:(CGRect)rect NS_AVAILABLE_IOS(6_0);
//@end
//
//typedef NS_ENUM(NSInteger, NSStringDrawingOptions) {
//    NSStringDrawingTruncatesLastVisibleLine = 1 << 5, // Truncates and adds the ellipsis character to the last visible line if the text doesn't fit into the bounds specified. Ignored if NSStringDrawingUsesLineFragmentOrigin is not also set.
//    NSStringDrawingUsesLineFragmentOrigin = 1 << 0, // The specified origin is the line fragment origin, not the base line origin
//    NSStringDrawingUsesFontLeading = 1 << 1, // Uses the font leading for calculating line heights
//    NSStringDrawingUsesDeviceMetrics = 1 << 3, // Uses image glyph bounds instead of typographic bounds
//} NS_ENUM_AVAILABLE_IOS(6_0);
//
//
//// NOTE: All of the following methods will default to drawing on a baseline, limiting drawing to a single line.
//// To correctly draw and size multi-line text, pass NSStringDrawingUsesLineFragmentOrigin in the options parameter.
//@interface NSString (NSExtendedStringDrawing)
//- (void)drawWithRect:(CGRect)rect options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(7_0);
//- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(7_0);
//@end
//
//@interface NSAttributedString (NSExtendedStringDrawing)
//- (void)drawWithRect:(CGRect)rect options:(NSStringDrawingOptions)options context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(6_0);
//- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(6_0);
//@end


