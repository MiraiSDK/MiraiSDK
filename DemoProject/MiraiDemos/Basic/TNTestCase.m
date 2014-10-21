//
//  TNTestCase.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/7/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTestCase.h"

@implementation TNTestCase

- (id)initWithName:(NSString *)name action:(TestAction)action
{
    self = [super init];
    if (self) {
        _name = name;
        _action = [action copy];
    }
    return self;
}

+ (instancetype)testCaseWithName:(NSString *)name action:(TestAction)action
{
    return [[self alloc] initWithName:name action:action];
}
@end
