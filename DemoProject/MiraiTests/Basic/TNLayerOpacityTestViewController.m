//
//  TNLayerOpacityTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 12/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLayerOpacityTestViewController.h"

@interface TNLayerOpacityTestViewController ()

@end

@implementation TNLayerOpacityTestViewController
+ (NSString *)testName
{
    return @"Layer Opacity";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"ContentsGravity_Small.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    CGRect frame = imageView.frame;
    frame = CGRectOffset(frame, frame.size.width/2, frame.size.height/2);
    UIView *black = [[UIView alloc] initWithFrame:frame];
    UIColor *bgc = [UIColor colorWithRed:0.8 green:0.2 blue:0.1 alpha:0.5];
    
    black.backgroundColor = bgc;
    [self.view addSubview:black];
    
    [self logColor:bgc];
}

- (UIColor *)cmykColor
{
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceCMYK();
    CGFloat components[] = {0.5,0.4,0.3,0.2,0.9};
    
    CGColorRef cc = CGColorCreate(cs, components);
    UIColor *c = [UIColor colorWithCGColor:cc];
    return c;
}

- (NSString *)componentsDescriptionForCGColor:(CGColorRef)color
{
    size_t numberOfComponents = CGColorGetNumberOfComponents(color);
    
    const CGFloat * componentsCG = CGColorGetComponents(color);
    NSMutableArray *array = [NSMutableArray array];
    for (int idx = 0; idx < numberOfComponents; idx++) {
        CGFloat comp = componentsCG[idx];
        [array addObject:@(comp).stringValue];
    }
    NSString *result = [array componentsJoinedByString:@","];
    return result;
}

- (void)logCGColor:(CGColorRef)color
{
    NSLog(@"cgColor:%@",color);
    size_t numberOfComponents = CGColorGetNumberOfComponents(color);
    NSString *result = [self componentsDescriptionForCGColor:color];
    NSLog(@"numberOfComponents: %zu components:%@",numberOfComponents,result);
}

- (void)logrgb
{
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    size_t spaceNumberOfComponents = CGColorSpaceGetNumberOfComponents(cs);
    NSLog(@"deviceRGB: NumberOfComponents:%zu",spaceNumberOfComponents);
    
    CGFloat components[] = {0.8,0.2,0.1,0.5};
    CGColorRef s = CGColorCreate(cs, components);

    [self logCGColor:s];
}

- (void)logColor:(UIColor *)uicolor
{
    NSLog(@"color:%@",uicolor);

    [self logCGColor:uicolor.CGColor];
}

@end
