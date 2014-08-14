//
//  TNMultiGestureTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/8/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMultiGestureTestViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

NSString* NSStringFromGesState(UIGestureRecognizerState state)
{
    switch (state) {
        case UIGestureRecognizerStatePossible:return @"Possible";break;
        case UIGestureRecognizerStateBegan:return @"Began";break;
        case UIGestureRecognizerStateChanged:return @"Changed";break;
        case UIGestureRecognizerStateEnded:return @"Ended";break;
        case UIGestureRecognizerStateCancelled:return @"Cancelled";break;
        case UIGestureRecognizerStateFailed:return @"Failed";break;
            
            
        default:
            return @"unknow";
            break;
    }
}

#pragma mark -
@interface TNTapGestureRecognizer : UITapGestureRecognizer
@end
@implementation TNTapGestureRecognizer
- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end

@interface TNSwipeGestureRecognizer : UISwipeGestureRecognizer
@end
@implementation TNSwipeGestureRecognizer
- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end

@interface TNLongPressGestureRecognizer : UILongPressGestureRecognizer
@end
@implementation TNLongPressGestureRecognizer
- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end

@interface TNRotationGestureRecognizer : UIRotationGestureRecognizer
@end
@implementation TNRotationGestureRecognizer
- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end

@interface TNPinchGestureRecognizer : UIPinchGestureRecognizer
@end
@implementation TNPinchGestureRecognizer
- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end

@interface TNPanGestureRecognizer : UIPanGestureRecognizer
@end
@implementation TNPanGestureRecognizer
- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end

#pragma mark -
@interface TNMultiGestureTestViewController ()

@end

@implementation TNMultiGestureTestViewController

+ (NSString *)testName
{
    return @"Multi Gesture";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[TNTapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap:)];
    [self.view addGestureRecognizer:tap];
    
    UIRotationGestureRecognizer *rotation = [[TNRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handle_rotation:)];
    [self.view addGestureRecognizer:rotation];
    
    UIPinchGestureRecognizer *pinch = [[TNPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pinch:)];
    [self.view addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[TNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handle_longpress:)];
    [self.view addGestureRecognizer:longPress];
    
//    UIPanGestureRecognizer *pan = [[TNPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
//    [self.view addGestureRecognizer:pan];
    
    UISwipeGestureRecognizer *swipe = [[TNSwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handle_swip:)];
    [self.view addGestureRecognizer:swipe];
    
}

- (void)handle_tap:(UITapGestureRecognizer *)ges
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,NSStringFromGesState(ges.state));
}

- (void)handle_rotation:(UIRotationGestureRecognizer *)ges
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,NSStringFromGesState(ges.state));
}

- (void)handle_pinch:(UIPinchGestureRecognizer *)ges
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,NSStringFromGesState(ges.state));
}

- (void)handle_longpress:(UILongPressGestureRecognizer *)ges
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,NSStringFromGesState(ges.state));
}

- (void)handle_pan:(UIPanGestureRecognizer *)ges
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,NSStringFromGesState(ges.state));
}

- (void)handle_swip:(UISwipeGestureRecognizer *)ges
{
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,NSStringFromGesState(ges.state));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super touchesCancelled:touches withEvent:event];
}
@end
