//
//  TNViewTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewTestViewController.h"
#import "TNCustomView.h"

@interface TNDrawRectView : UIView
@property (nonatomic, strong) UIImage *image;
@end
@implementation TNDrawRectView

- (void)drawRect:(CGRect)rect
{
//    [self.image drawAtPoint:CGPointMake(10, 10)];
    CGRect ir = {CGPointMake(10, 10), self.image.size};
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    // flip coordinate
    CGContextTranslateCTM(ctx, 0, ir.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    
    //
    ir.origin.y = -ir.origin.y;
    CGContextDrawImage(ctx, ir, self.image.CGImage);
    CGContextRestoreGState(ctx);

    CGRect r = CGRectMake(0, 0, 50, 50);
    [[UIColor redColor] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), r);
}

@end
@interface TNViewTestViewController ()
@property (nonatomic, strong) NSArray *actions;

@end
@implementation TNViewTestViewController
+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UIView";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // custom view
//    TNCustomView *custom = [[TNCustomView alloc] initWithFrame:CGRectMake(0, 80, 300, 300)];
//    [self.view addSubview:custom];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    bgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bgView];
    
    // clip
    UIView *clipView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    clipView.clipsToBounds = YES;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 200, 200)];
    contentView.backgroundColor = [UIColor redColor];
    [clipView addSubview:contentView];

    [self.view addSubview:clipView];

    
    UIImage *image = [UIImage imageNamed:@"ContentsGravity_300x400.jpg"];
    TNDrawRectView *drv = [[TNDrawRectView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    drv.image = image;
    [self.view addSubview:drv];
}


@end
