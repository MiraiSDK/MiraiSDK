//
//  TNPinchAndRotationViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPinchAndRotationViewController.h"

@interface TNPinchAndRotationViewController ()
@property (nonatomic, strong) UIView *subView;
@end

@implementation TNPinchAndRotationViewController

+ (NSString *)testName
{
    return @"Pinch and Rotation";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    self.subView = v;
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pinchAndRotation:)];
    [self.view addGestureRecognizer:pinch];
    pinch.delegate = self;
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pinchAndRotation:)];
    [self.view addGestureRecognizer:rotation];
    rotation.delegate = self;
}

- (void)handle_pinchAndRotation:(UIGestureRecognizer *)ges
{
    static CGAffineTransform originT;
    static CGAffineTransform rotationT;
    static CGAffineTransform scaleT;
    static int gesCount = 0;
    switch (ges.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            if (gesCount == 0) {
                originT = self.subView.transform;
                scaleT = CGAffineTransformIdentity;
                rotationT = CGAffineTransformIdentity;
            }
            
            if ([ges isKindOfClass:[UIPinchGestureRecognizer class]]) {
                scaleT = CGAffineTransformIdentity;
            } else {
                rotationT = CGAffineTransformIdentity;
            }
            
            gesCount ++;
            
            break;
        case UIGestureRecognizerStateChanged:
            if ([ges isKindOfClass:[UIPinchGestureRecognizer class]]) {
                UIPinchGestureRecognizer *pinch = ges;
                scaleT = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
            } else {
                UIRotationGestureRecognizer *rotation = ges;
                
                rotationT = CGAffineTransformMakeRotation(rotation.rotation);
            }
            break;
        case UIGestureRecognizerStateEnded:
            gesCount --;
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateFailed:
            break;
            
        default:
            break;
    }
    
    self.subView.transform = CGAffineTransformConcat(CGAffineTransformConcat(originT,scaleT),rotationT);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
