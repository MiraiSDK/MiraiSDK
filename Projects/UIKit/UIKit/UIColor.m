//
//  UIColor.m
//  UIKit
//
//  Created by Chen Yonghui on 1/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIColor.h"
#import <dispatch/dispatch.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIGraphics.h"

@interface UIColor ()
@property (nonatomic, strong) CGColorRef color;
@end

@implementation UIColor

#pragma mark - Convenience methods
+ (UIColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha
{
    return [[self alloc] initWithWhite:white alpha:alpha];
}

+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
    return [[self alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [[self alloc] initWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithCGColor:(CGColorRef)cgColor
{
    return [[self alloc] initWithCGColor:cgColor];
}

+ (UIColor *)colorWithPatternImage:(UIImage *)image
{
    
    return [[self alloc] initWithPatternImage:image];
}

#pragma mark - Initializers
- (UIColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha
{
    self = [super init];
    if (self) {
        _color = CGColorCreateGenericGray(white, alpha);
    }
    return self;
}

- (UIColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
    self = [super init];
    if (self) {
        NSLog(@"unimplemented methods %s",__PRETTY_FUNCTION__);
        _color = CGColorCreateGenericGray(0, 1);
    }
    return self;
}

- (UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    self = [super init];
    if (self) {
        _color = CGColorCreateGenericRGB(red, green, blue, alpha);
    }
    return self;
}

- (UIColor *)initWithCGColor:(CGColorRef)cgColor
{
    self = [super init];
    if (self) {
        _color = cgColor;
    }
    return self;
}

- (UIColor *)initWithPatternImage:(UIImage*)image
{
    self = [super init];
    if (self) {
        NSLog(@"unimplemented methods %s",__PRETTY_FUNCTION__);
        _color = CGColorCreateGenericGray(0, 1);
    }
    return self;
}
//- (UIColor *)initWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);


+ (UIColor *)blackColor
{
    static UIColor *_black = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _black = [UIColor colorWithWhite:0 alpha:1];
    });
    return _black;
}

+ (UIColor *)darkGrayColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithWhite:0.333 alpha:1];
    });
    return _value;
}

+ (UIColor *)lightGrayColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithWhite:0.667 alpha:1];
    });
    return _value;
}

+ (UIColor *)whiteColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithWhite:1.0 alpha:1];
    });
    return _value;
}

+ (UIColor *)grayColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithWhite:0.5 alpha:1];
    });
    return _value;
}

+ (UIColor *)redColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)greenColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)blueColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)cyanColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)yellowColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)magentaColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)orangeColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)purpleColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)brownColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithRed:0.6 green:0.4 blue:0.2 alpha:1.0];
    });
    return _value;
}

+ (UIColor *)clearColor
{
    static UIColor *_value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _value = [UIColor colorWithWhite:0.0 alpha:0.0];
    });
    return _value;
}


- (void)set
{
    [self setFill];
    [self setStroke];
}

- (void)setFill
{
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _color);
}

- (void)setStroke
{
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _color);
}

- (BOOL)getWhite:(CGFloat *)white alpha:(CGFloat *)alpha
{
    return 0;
}

- (BOOL)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation brightness:(CGFloat *)brightness alpha:(CGFloat *)alpha
{
    return NO;
}

- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    return NO;
}

- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha
{
    CGColorRef clr = CGColorCreateCopyWithAlpha(_color, alpha);
    return [UIColor colorWithCGColor:clr];
}

- (CGColorRef)CGColor
{
    return _color;
}

- (id)copyWithZone: (NSZone*)zone
{
    UIColor *copy = [UIColor colorWithCGColor:_color];
    return copy;
}
@end
