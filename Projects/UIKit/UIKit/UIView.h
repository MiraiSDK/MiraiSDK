//
//  UIView.h
//  UIKit
//
//  Created by Chen Yonghui on 12/6/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIResponder.h>
#import <UIKit/UIKitDefines.h>
#import <CoreGraphics/CoreGraphics.h>

@class UIBezierPath, UIEvent, UIWindow, UIViewController, UIColor, UIGestureRecognizer, UIMotionEffect, CALayer;

@interface UIView : UIResponder
+ (Class)layerClass;
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic,readonly,retain) CALayer  *layer;

//Geometry
@property(nonatomic) CGRect            frame;
@property(nonatomic) CGRect            bounds;
@property(nonatomic) CGPoint           center;
@property(nonatomic) CGAffineTransform transform;

@end
