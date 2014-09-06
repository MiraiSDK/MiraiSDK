//
//  TNPinchTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPinchTestViewController.h"

@interface TNPinchTestViewController ()
@property (nonatomic, strong) UIView *subView;

@end

@implementation TNPinchTestViewController

+ (NSString *)testName
{
    return @"Pinch";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    self.subView = v;

    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pinch:)];
    [self.view addGestureRecognizer:pinch];
}



- (void)handle_pinch:(UIPinchGestureRecognizer *)pinch
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    static CGAffineTransform t;
    switch (pinch.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            t = self.subView.transform;
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.subView.transform = CGAffineTransformScale(t, pinch.scale, pinch.scale);
        }
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
