//
//  NBRadialGradientLayer.h
//  NextBook
//
//  Created by Chen Yonghui on 5/22/13.
//  Copyright (c) 2013 Shanghai TinyNetwork. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface NBRadialGradientLayer : CALayer

@property(strong,nonatomic) NSArray *colors;

@property(copy) NSArray *locations;

@property CGPoint startPoint, endPoint;
@property CGFloat endRadius;
@property CGSize natureSize;

@end
