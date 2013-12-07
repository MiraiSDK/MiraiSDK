//
//  UIGraphics.m
//  UIKit
//
//  Created by Chen Yonghui on 12/7/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIGraphics.h"

static NSMutableArray* contextStack()
{
    static NSMutableArray *_contextStack;
    if (!_contextStack) {
        _contextStack = [NSMutableArray array];
    }
    return _contextStack;
}

CGContextRef UIGraphicsGetCurrentContext(void)
{
    return [contextStack() lastObject];
}

void UIGraphicsPushContext(CGContextRef context)
{
    [contextStack() addObject:context];
}

void UIGraphicsPopContext(void)
{
    [contextStack() removeLastObject];
}

