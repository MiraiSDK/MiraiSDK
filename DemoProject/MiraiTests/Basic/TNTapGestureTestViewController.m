//
//  TNTapGestureTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/7/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTapGestureTestViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

NSString* NSStringFromGestureState(UIGestureRecognizerState state)
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

@interface UIGestureRecognizer ()
-(BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges;
@end
@interface TNCTapGestureRecognizer : UITapGestureRecognizer
@end
@implementation TNCTapGestureRecognizer
- (BOOL)_isExcludedByGesture:(UIGestureRecognizer *)ges
{
    BOOL excluded = [super _isExcludedByGesture:ges];
    NSLog(@"<%p> %s:<%p,%@> -> %@ ",self,__PRETTY_FUNCTION__, ges,ges.class,excluded?@"YES":@"NO");
    return excluded;
}

- (void)setState:(UIGestureRecognizerState)state
{
    NSLog(@"<%p>%s %@",self,__PRETTY_FUNCTION__, NSStringFromGestureState(state));
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

@interface TNButton : UIButton

@end
@implementation TNButton

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL b = [super gestureRecognizerShouldBegin:gestureRecognizer];
    return b;
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

- (BOOL)isKindOfClass:(Class)aClass
{
    return [super isKindOfClass:aClass];
}


@end

@interface TNTapView : UIControl
@end
@implementation TNTapView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL b = [super gestureRecognizerShouldBegin:gestureRecognizer];
    return NO;
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

@interface TNTapGestureTestViewController ()

@end

@implementation TNTapGestureTestViewController

+ (NSString *)testName
{
    return @"Tap";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    TNCTapGestureRecognizer *tap = [[TNCTapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap:)];
    [self.view addGestureRecognizer:tap];
    

    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    subview.backgroundColor = [UIColor redColor];
    [self.view addSubview:subview];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap2:)];
    [subview addGestureRecognizer:tap2];
    
    TNButton *button = [TNButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = CGPointMake(100, 400);
    [self.view addSubview:button];
    
    TNTapView *tpv = [[TNTapView alloc] initWithFrame:CGRectMake(200, 400, 200, 200)];
    tpv.backgroundColor = [UIColor greenColor];
    [tpv addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tpv];
}

- (void)handle_tap:(UIGestureRecognizer *)ges
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)handle_tap2:(UIGestureRecognizer *)ges
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)didPressedButton:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}


@end
