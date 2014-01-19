//
//  UIFontDescriptor.h
//  UIKit
//
//  Created by Chen Yonghui on 1/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

typedef NS_OPTIONS(uint32_t, UIFontDescriptorSymbolicTraits) {
    /* Symbolic Font Traits (Typeface info - lower 16 bits of UIFontDescriptorSymbolicTraits) */
    /*
     UIFontDescriptorSymbolicTraits symbolically describes stylistic aspects of a font. The upper 16 bits is used to describe appearance of the font whereas the lower 16 bits for typeface. The font appearance information represented by the upper 16 bits can be used for stylistic font matching.
     */
    UIFontDescriptorTraitItalic = 1u << 0,
    UIFontDescriptorTraitBold = 1u << 1,
    UIFontDescriptorTraitExpanded = 1u << 5, // expanded and condensed traits are mutually exclusive
    UIFontDescriptorTraitCondensed = 1u << 6,
    UIFontDescriptorTraitMonoSpace = 1u << 10, // Use fixed-pitch glyphs if available. May have multiple glyph advances (most CJK glyphs may contain two spaces)
    UIFontDescriptorTraitVertical = 1u << 11, // Use vertical glyph variants and metrics
    UIFontDescriptorTraitUIOptimized = 1u << 12, // Synthesize appropriate attributes for UI rendering such as control titles if necessary
    UIFontDescriptorTraitTightLeading = 1u << 15, // Use tighter leading values
    UIFontDescriptorTraitLooseLeading = 1u << 16, // Use looser leading values
    
    /* Font appearance info (upper 16 bits of NSFontSymbolicTraits */
    /* UIFontDescriptorClassFamily classifies certain stylistic qualities of the font. These values correspond closely to the font class values in the OpenType 'OS/2' table. The class values are bundled in the upper four bits of the UIFontDescriptorSymbolicTraits and can be accessed via UIFontDescriptorClassMask. For specific meaning of each identifier, refer to the OpenType specification.
     */
    UIFontDescriptorClassMask = 0xF0000000,
    
    UIFontDescriptorClassUnknown = 0u << 28,
    UIFontDescriptorClassOldStyleSerifs = 1u << 28,
    UIFontDescriptorClassTransitionalSerifs = 2u << 28,
    UIFontDescriptorClassModernSerifs = 3u << 28,
    UIFontDescriptorClassClarendonSerifs = 4u << 28,
    UIFontDescriptorClassSlabSerifs = 5u << 28,
    UIFontDescriptorClassFreeformSerifs = 7u << 28,
    UIFontDescriptorClassSansSerif = 8u << 28,
    UIFontDescriptorClassOrnamentals = 9u << 28,
    UIFontDescriptorClassScripts = 10u << 28,
    UIFontDescriptorClassSymbolic = 12u << 28
};

typedef NSUInteger UIFontDescriptorClass;

@class NSMutableDictionary, NSDictionary, NSArray, NSSet;

@interface UIFontDescriptor : NSObject <NSCopying, NSCoding>

@property(nonatomic, readonly) NSString *postscriptName;
@property(nonatomic, readonly) CGFloat   pointSize;
@property(nonatomic, readonly) CGAffineTransform matrix;
@property(nonatomic, readonly) UIFontDescriptorSymbolicTraits symbolicTraits;

- (id)objectForKey:(NSString *)anAttribute;

- (NSDictionary *)fontAttributes;

- (NSArray *)matchingFontDescriptorsWithMandatoryKeys:(NSSet *)mandatoryKeys;

+ (UIFontDescriptor *)fontDescriptorWithFontAttributes:(NSDictionary *)attributes;
+ (UIFontDescriptor *)fontDescriptorWithName:(NSString *)fontName size:(CGFloat)size;
+ (UIFontDescriptor *)fontDescriptorWithName:(NSString *)fontName matrix:(CGAffineTransform)matrix;

+ (UIFontDescriptor *)preferredFontDescriptorWithTextStyle:(NSString *)style;

- (instancetype)initWithFontAttributes:(NSDictionary *)attributes;

- (UIFontDescriptor *)fontDescriptorByAddingAttributes:(NSDictionary *)attributes;
- (UIFontDescriptor *)fontDescriptorWithSymbolicTraits:(UIFontDescriptorSymbolicTraits)symbolicTraits;
- (UIFontDescriptor *)fontDescriptorWithSize:(CGFloat)newPointSize;
- (UIFontDescriptor *)fontDescriptorWithMatrix:(CGAffineTransform)matrix;
- (UIFontDescriptor *)fontDescriptorWithFace:(NSString *)newFace;
- (UIFontDescriptor *)fontDescriptorWithFamily:(NSString *)newFamily;

@end

UIKIT_EXTERN NSString *const UIFontDescriptorFamilyAttribute;
UIKIT_EXTERN NSString *const UIFontDescriptorNameAttribute;
UIKIT_EXTERN NSString *const UIFontDescriptorFaceAttribute;
UIKIT_EXTERN NSString *const UIFontDescriptorSizeAttribute;
UIKIT_EXTERN NSString *const UIFontDescriptorVisibleNameAttribute;

UIKIT_EXTERN NSString *const UIFontDescriptorMatrixAttribute; // An NSValue containing a CGAffineTransform. (default: identity matrix)
UIKIT_EXTERN NSString *const UIFontDescriptorCharacterSetAttribute; // An NSCharacterSet instance representing a set of Unicode characters covered by the font. (default: supplied by font)
UIKIT_EXTERN NSString *const UIFontDescriptorCascadeListAttribute; // An NSArray instance. Each member of the array is a sub-descriptor. (default: the system default cascading list for user's locale)
UIKIT_EXTERN NSString *const UIFontDescriptorTraitsAttribute; // An NSDictionary instance fully describing font traits. (default: supplied by font)
UIKIT_EXTERN NSString *const UIFontDescriptorFixedAdvanceAttribute; // A float represented as an NSNumber. The value overrides glyph advancement specified by the font. (default: 0.0)
UIKIT_EXTERN NSString *const UIFontDescriptorFeatureSettingsAttribute; // An array of dictionaries representing non-default font feature settings. Each dictionary contains UIFontFeatureTypeIdentifierKey and UIFontFeatureSelectorIdentifierKey.

// An NSString containing the desired Text Style
UIKIT_EXTERN NSString *const UIFontDescriptorTextStyleAttribute;

// Font traits keys
// This key is used with a trait dictionary to get the symbolic traits value as an NSNumber.
UIKIT_EXTERN NSString *const UIFontSymbolicTrait;

// This key is used with a trait dictionary to get the normalized weight value as an NSNumber. The valid value range is from -1.0 to 1.0. The value of 0.0 corresponds to the regular or medium font weight.
UIKIT_EXTERN NSString *const UIFontWeightTrait;

// This key is used with a trait dictionary to get the relative inter-glyph spacing value as an NSNumber. The valid value range is from -1.0 to 1.0. The value of 0.0 corresponds to the regular glyph spacing.
UIKIT_EXTERN NSString *const UIFontWidthTrait;

// This key is used with a trait dictionary to get the relative slant angle value as an NSNumber. The valid value range is from -1.0 to 1.0. The value or 0.0 corresponds to 0 degree clockwise rotation from the vertical and 1.0 corresponds to 30 degrees clockwise rotation.
UIKIT_EXTERN NSString *const UIFontSlantTrait;

// Font feature keys
// A number object specifying font feature type such as ligature, character shape, etc.
UIKIT_EXTERN NSString *const UIFontFeatureTypeIdentifierKey;

// A number object specifying font feature selector such as common ligature off, traditional character shape, etc.
UIKIT_EXTERN NSString *const UIFontFeatureSelectorIdentifierKey;

// Font text styles, semantic descriptions of the intended use for a font returned by +[UIFont preferredFontForTextStyle:]
UIKIT_EXTERN NSString *const UIFontTextStyleHeadline;
UIKIT_EXTERN NSString *const UIFontTextStyleBody;
UIKIT_EXTERN NSString *const UIFontTextStyleSubheadline;
UIKIT_EXTERN NSString *const UIFontTextStyleFootnote;
UIKIT_EXTERN NSString *const UIFontTextStyleCaption1;
UIKIT_EXTERN NSString *const UIFontTextStyleCaption2;
