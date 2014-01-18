//
//  UITouch.m
//  UIKit
//
//  Created by Chen Yonghui on 1/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UITouch.h"

@implementation UITouch
- (id)init
{
    self = [super init];
    if (self) {
        _phase = UITouchPhaseCancelled;
    }
    return self;
}

- (CGPoint)locationInView:(UIView *)view
{
    return CGPointZero;
}

- (CGPoint)previousLocationInView:(UIView *)view
{
    return CGPointZero;
}
@end
