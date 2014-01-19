//
//  UIFont.h
//  UIKit
//
//  Created by Chen Yonghui on 1/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIFontDescriptor.h>

@interface UIFont : NSObject <NSCopying>
+ (UIFont *)preferredFontForTextStyle:(NSString *)style;

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize;

+ (NSArray *)familyNames;

+ (NSArray *)fontNamesForFamilyName:(NSString *)familyName;

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)italicSystemFontOfSize:(CGFloat)fontSize;

@property(nonatomic,readonly,retain) NSString *familyName;
@property(nonatomic,readonly,retain) NSString *fontName;
@property(nonatomic,readonly)        CGFloat   pointSize;
@property(nonatomic,readonly)        CGFloat   ascender;
@property(nonatomic,readonly)        CGFloat   descender;
@property(nonatomic,readonly)        CGFloat   capHeight;
@property(nonatomic,readonly)        CGFloat   xHeight;
@property(nonatomic,readonly)        CGFloat   lineHeight;
@property(nonatomic,readonly)        CGFloat   leading;

- (UIFont *)fontWithSize:(CGFloat)fontSize;

+ (UIFont *)fontWithDescriptor:(UIFontDescriptor *)descriptor size:(CGFloat)pointSize;

- (UIFontDescriptor *)fontDescriptor;

@end
