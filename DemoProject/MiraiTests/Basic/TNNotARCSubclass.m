//
//  TNNotARCSubclass.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/3/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNNotARCSubclass.h"

@implementation TNNotARCSubclass
{
    BOOL _p2;
}
@synthesize p1 = _p1;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _p2 = YES;
    }
    return self;
}
- (void)test
{
    NSString *s = @"s";
    [s retain];
    [s release];
}
@end
