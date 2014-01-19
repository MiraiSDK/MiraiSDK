//
//  NSParagraphStyle.m
//  UIKit
//
//  Created by Chen Yonghui on 1/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "NSParagraphStyle.h"

@implementation NSTextTab
- (id)initWithTextAlignment:(NSTextAlignment)alignment location:(CGFloat)loc options:(NSDictionary *)options
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSCharacterSet *)columnTerminatorsForLocale:(NSLocale *)aLocale
{
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@implementation NSParagraphStyle
+ (NSParagraphStyle *)defaultParagraphStyle
{
    return nil;
}

+ (NSWritingDirection)defaultWritingDirectionForLanguage:(NSString *)languageName
{
    return NSWritingDirectionNatural;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return nil;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return nil;
}

@end

@implementation NSMutableParagraphStyle


@end
