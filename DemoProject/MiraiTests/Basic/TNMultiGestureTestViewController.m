//
//  TNMultiGestureTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/8/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMultiGestureTestViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface UIGestureRecognizer ()
-(BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges;
@end

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
- (BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges
{
    BOOL excluded = [super _isExcludedByGesture:ges];
    NSLog(@"<%p> %s:<%p,%@> -> %@ ",self,__PRETTY_FUNCTION__, ges,ges.class,excluded?@"YES":@"NO");
    return excluded;
}

- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"<%p>%s %@",self,__PRETTY_FUNCTION__, NSStringFromGesState(state));
    [super setState:state];
}
- (void)reset
{
    NSLog(@"<%p>%s",self,__PRETTY_FUNCTION__);
    [super reset];
}
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    BOOL can = [super canPreventGestureRecognizer:preventedGestureRecognizer];
    NSLog(@"<%p>%s:<%p,%@> ->%@",self,__PRETTY_FUNCTION__, preventedGestureRecognizer,preventedGestureRecognizer.class,can?@"YES":@"NO");
    return can;
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    BOOL can = [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
    NSLog(@"<%p>%s:<%p,%@> ->%@",self,__PRETTY_FUNCTION__, preventingGestureRecognizer,preventingGestureRecognizer.class,can?@"YES":@"NO");
    return can;
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
- (BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges
{
    BOOL excluded = [super _isExcludedByGesture:ges];
    NSLog(@"%s:<%p,%@> -> %@ ",__PRETTY_FUNCTION__, ges,ges.class,excluded?@"YES":@"NO");
    return excluded;
}

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
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventedGestureRecognizer,preventedGestureRecognizer.class);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventingGestureRecognizer,preventingGestureRecognizer.class);
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
- (BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges
{
    BOOL excluded = [super _isExcludedByGesture:ges];
    NSLog(@"%s:<%p,%@> -> %@ ",__PRETTY_FUNCTION__, ges,ges.class,excluded?@"YES":@"NO");
    return excluded;
}

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
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventedGestureRecognizer,preventedGestureRecognizer.class);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventingGestureRecognizer,preventingGestureRecognizer.class);
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
- (BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges
{
    BOOL excluded = [super _isExcludedByGesture:ges];
    NSLog(@"%s:<%p,%@> -> %@ ",__PRETTY_FUNCTION__, ges,ges.class,excluded?@"YES":@"NO");
    return excluded;
}

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
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventedGestureRecognizer,preventedGestureRecognizer.class);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventingGestureRecognizer,preventingGestureRecognizer.class);
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
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventedGestureRecognizer,preventedGestureRecognizer.class);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventingGestureRecognizer,preventingGestureRecognizer.class);
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
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventedGestureRecognizer,preventedGestureRecognizer.class);
    return [super canPreventGestureRecognizer:preventedGestureRecognizer];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    NSLog(@"%s:<%p,%@> ",__PRETTY_FUNCTION__, preventingGestureRecognizer,preventingGestureRecognizer.class);
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
@interface TNMultiGestureTestViewController () <UIGestureRecognizerDelegate>

@end

@implementation TNMultiGestureTestViewController

+ (NSString *)testName
{
    return @"Multi Gesture";
}

#if 0
#define TNTapGestureRecognizer UITapGestureRecognizer
#define TNRotationGestureRecognizer UIRotationGestureRecognizer
#define TNPinchGestureRecognizer UIPinchGestureRecognizer
#define TNLongPressGestureRecognizer UILongPressGestureRecognizer
#define TNSwipeGestureRecognizer UISwipeGestureRecognizer
#define TNPanGestureRecognizer UIPanGestureRecognizer
#endif

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    red.backgroundColor = [UIColor redColor];
    [self.view addSubview:red];
    
    UITapGestureRecognizer *tap = [[TNTapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    UIRotationGestureRecognizer *rotation = [[TNRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handle_rotation:)];
//    [self.view addGestureRecognizer:rotation];
    
    UIPinchGestureRecognizer *pinch = [[TNPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pinch:)];
//    [self.view addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[TNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handle_longpress:)];
//    [self.view addGestureRecognizer:longPress];
    
//    UIPanGestureRecognizer *pan = [[TNPanGestureRecognizer alloc] initWithTarget:self action:@selector(handle_pan:)];
//    [self.view addGestureRecognizer:pan];
    
    UISwipeGestureRecognizer *swipe = [[TNSwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handle_swip:)];
//    [self.view addGestureRecognizer:swipe];
    
    TNTapGestureRecognizer *tap2 = [[TNTapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap2:)];
    tap2.delegate = self;
    [red addGestureRecognizer:tap2];
    
}

- (void)handle_tap2:(UITapGestureRecognizer *)ges
{
    NSLog(@"%s: ges:%p %@",__PRETTY_FUNCTION__,ges,NSStringFromGesState(ges.state));
}

- (void)handle_tap:(UITapGestureRecognizer *)ges
{
    NSLog(@"%s: ges:%p %@",__PRETTY_FUNCTION__,ges, NSStringFromGesState(ges.state));
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

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s gesture:%@",__PRETTY_FUNCTION__,gestureRecognizer);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%s gesture:%@ touch:%@",__PRETTY_FUNCTION__,gestureRecognizer,touch);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"%s gesture:<%p %@> other:<%p %@>",__PRETTY_FUNCTION__,gestureRecognizer,gestureRecognizer.class, otherGestureRecognizer,otherGestureRecognizer.class);
    return YES;
}


@end
