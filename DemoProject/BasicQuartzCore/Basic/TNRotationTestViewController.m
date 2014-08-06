//
//  TNRotationTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNRotationTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TNRotationTestViewController ()
@property (nonatomic, strong) UIView *subView;

@end

@implementation TNRotationTestViewController

+ (NSString *)testName
{
    return @"Rotation";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    self.subView = v;

    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handle_rotation:)];
    [self.view addGestureRecognizer:rotation];

//    self.subView.transform = CGAffineTransformMakeTranslation(100, 100);

    [UIView animateWithDuration:3 animations:^{
//        self.subView.transform = CGAffineTransformMakeRotation(1);
//        self.subView.layer.transform = CATransform3DMakeRotation(1, 0, 0, 1);
        self.subView.layer.transform = CATransform3DMakeTranslation(100, 100, 0);
    }];
}

- (void)handle_rotation:(UIRotationGestureRecognizer *)rotation
{
    static CGAffineTransform t;
    NSLog(@"%s, rotation:%.2f",__PRETTY_FUNCTION__,rotation.rotation);
    switch (rotation.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            t = self.subView.transform;
            break;
        case UIGestureRecognizerStateChanged:
            self.subView.transform = CGAffineTransformRotate(t, rotation.rotation);
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateFailed:
            break;
            
        default:
            break;
    }
}

@end
