//
//  UIGeometry.m
//  UIKit
//
//  Created by Chen Yonghui on 1/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIGeometry.h"

const UIEdgeInsets UIEdgeInsetsZero = {0.0f, 0.0f, 0.0f, 0.0f};
const UIOffset UIOffsetZero = {0.0f, 0.0f};

NSString *NSStringFromCGPoint(CGPoint point){
    return NSStringFromPoint(NSPointFromCGPoint(point));
}

NSString *NSStringFromCGSize(CGSize size)
{
    return NSStringFromSize(NSSizeFromCGSize(size));
}

NSString *NSStringFromCGRect(CGRect rect)
{
    return NSStringFromRect(NSRectFromCGRect(rect));
}

NSString *NSStringFromCGAffineTransform(CGAffineTransform transform){
    return [NSString stringWithFormat:@"[%g, %g, %g, %g, %g, %g]", transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty];
}

NSString *NSStringFromUIEdgeInsets(UIEdgeInsets insets)
{
    return [NSString stringWithFormat:@"{%g, %g, %g, %g}", insets.top, insets.left, insets.bottom, insets.right];
}

NSString *NSStringFromUIOffset(UIOffset offset)
{
    return [NSString stringWithFormat:@"{%g, %g}", offset.horizontal, offset.vertical];
}

CGPoint CGPointFromString(NSString *string)
{
    return NSPointToCGPoint(NSPointFromString(string));
}

CGSize CGSizeFromString(NSString *string)
{
    return NSSizeToCGSize(NSSizeFromString(string));
}

CGRect CGRectFromString(NSString *string)
{
    return NSRectToCGRect(NSRectFromString(string));
}

CGAffineTransform CGAffineTransformFromString(NSString *string)
{
    NSString *trim = [string substringWithRange:NSMakeRange(1, string.length - 2)];
    NSArray *components = [trim componentsSeparatedByString:@","];
    
    if (components.count == 6) {
        CGAffineTransform t = CGAffineTransformMake([[components objectAtIndex:0] floatValue],
                                                    [[components objectAtIndex:1] floatValue],
                                                    [[components objectAtIndex:2] floatValue],
                                                    [[components objectAtIndex:3] floatValue],
                                                    [[components objectAtIndex:4] floatValue],
                                                    [[components objectAtIndex:5] floatValue]);
        return t;
    }
    return CGAffineTransformIdentity;
}

UIEdgeInsets UIEdgeInsetsFromString(NSString *string)
{
    NSString *trim = [string substringWithRange:NSMakeRange(1, string.length - 2)];
    NSArray *components = [trim componentsSeparatedByString:@","];
    if (components.count == 4) {
        return UIEdgeInsetsMake([[components objectAtIndex:0] floatValue],
                         [[components objectAtIndex:1] floatValue],
                         [[components objectAtIndex:2] floatValue],
                         [[components objectAtIndex:3] floatValue]);
    }
    return UIEdgeInsetsZero;
}

UIOffset UIOffsetFromString(NSString *string)
{
    NSString *trim = [string substringWithRange:NSMakeRange(1, string.length - 2)];
    NSArray *components = [trim componentsSeparatedByString:@","];
    if (components.count == 2) {
        return UIOffsetMake([[components objectAtIndex:0] floatValue],
                            [[components objectAtIndex:1] floatValue]);
    }
    return UIOffsetZero;
}

@implementation NSValue (NSValueUIGeometryExtensions)
+ (NSValue *)valueWithCGPoint:(CGPoint)point
{
    return [NSValue valueWithPoint:NSPointFromCGPoint(point)];
}

- (CGPoint)CGPointValue
{
    return NSPointToCGPoint([self pointValue]);
}

+ (NSValue *)valueWithCGRect:(CGRect)rect
{
    return [NSValue valueWithRect:NSRectFromCGRect(rect)];
}

- (CGRect)CGRectValue
{
    return NSRectToCGRect([self rectValue]);
}

+ (NSValue *)valueWithCGSize:(CGSize)size
{
    return [NSValue valueWithSize:NSSizeFromCGSize(size)];
}

- (CGSize)CGSizeValue
{
    return NSSizeToCGSize([self sizeValue]);
}

+ (NSValue *)valueWithUIEdgeInsets:(UIEdgeInsets)insets
{
    return [NSValue valueWithBytes: &insets objCType: @encode(UIEdgeInsets)];
}

- (UIEdgeInsets)UIEdgeInsetsValue
{
    if(strcmp([self objCType], @encode(UIEdgeInsets)) == 0)
    {
        UIEdgeInsets insets;
        [self getValue: &insets];
        return insets;
    }
    return UIEdgeInsetsZero;
}

+ (NSValue *)valueWithUIOffset:(UIOffset)offset
{
    return [NSValue valueWithBytes: &offset objCType: @encode(UIOffset)];
}

- (UIOffset)UIOffsetValue
{
    if(strcmp([self objCType], @encode(UIOffset)) == 0)
    {
        UIOffset offset;
        [self getValue: &offset];
        return offset;
    }
    return UIOffsetZero;
}

+ (NSValue *)valueWithCGAffineTransform:(CGAffineTransform)transform
{
    return [NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)];
}

- (CGAffineTransform)CGAffineTransformValue
{
    if(strcmp([self objCType], @encode(CGAffineTransform)) == 0)
    {
        CGAffineTransform t;
        [self getValue: &t];
        return t;
    }
    return CGAffineTransformIdentity;
}
@end

@implementation NSCoder (NSCoderUIGeometryExtensions)
- (void)encodeCGPoint:(CGPoint)point forKey:(NSString *)key
{
    [self encodePoint:NSPointFromCGPoint(point) forKey:key];
}

- (CGPoint)decodeCGPointForKey:(NSString *)key
{
    return NSPointToCGPoint([self decodePointForKey:key]);
}

- (void)encodeCGRect:(CGRect)rect forKey:(NSString *)key
{
    [self encodeRect:NSRectFromCGRect(rect) forKey:key];
}

- (CGRect)decodeCGRectForKey:(NSString *)key
{
    return NSRectToCGRect([self decodeRectForKey:key]);
}

@end
