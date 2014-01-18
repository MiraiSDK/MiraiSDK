//
//  UIEvent.m
//  UIKit
//
//  Created by Chen Yonghui on 1/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIEvent.h"
#import "UITouch.h"

@implementation UIEvent {
    UITouch *_touch;
}

- (id)initWithEventType:(UIEventType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSSet *)allTouches
{
    return [NSSet setWithObject:_touch];
}

- (NSSet *)touchesForWindow:(UIWindow *)window
{
    return nil;
}

- (NSSet *)touchesForView:(UIView *)view
{
    return nil;
}

- (NSSet *)touchesForGestureRecognizer:(UIGestureRecognizer *)gesture
{
    return nil;
}

- (UIEventSubtype)subtype
{
    return UIEventSubtypeNone;
}

@end
