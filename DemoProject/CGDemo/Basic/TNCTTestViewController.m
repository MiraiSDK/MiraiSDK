//
//  TNCTTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCTTestViewController.h"
#import "TNCTView.h"
#import <CoreText/CoreText.h>

@interface TNCTTestViewController ()
@property (nonatomic, strong) TNCTView *ctView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TNCTTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Core Text Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAttributedString *att = [self attributedStringWithFontSize:17];

    TNCTView *v = [[TNCTView alloc] initWithFrame:self.view.bounds];
    v.attributedString = att;
    v.hidden = YES;
    [self.view addSubview:v];
    self.ctView = v;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [self imageForAttributedString:att];
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)handle_tap:(UITapGestureRecognizer *)tap
{
    if (self.ctView.isHidden) {
        self.ctView.hidden = NO;
        self.imageView.hidden = YES;
    } else {
        self.ctView.hidden = YES;
        self.imageView.hidden = NO;
    }
}

- (UIImage *)imageForAttributedString:(NSAttributedString *)attr
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    
    [attr drawInRect:self.view.bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Text
#if __ANDROID__
#define TN_ARC_BRIDGE
#else
#define TN_ARC_BRIDGE (__bridge id)
#endif
- (NSAttributedString *)attributedStringWithFontSize:(CGFloat)size
{
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)([self fontAttributes]));
    CTTextAlignment alignment = kCTTextAlignmentCenter;
    CTParagraphStyleSetting settings[] = {
        kCTParagraphStyleSpecifierAlignment,sizeof(CTTextAlignment),&alignment
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    CTFontRef font = CTFontCreateWithFontDescriptor(desc, size, NULL);
    
    UIColor *color = [UIColor blueColor];
    
    UIColor *textColor = [UIColor colorWithRed:125.0f/255.0f green:159.0f/255.0f blue:132.0f/255.0f alpha:1];
    
    NSMutableAttributedString *att= [[NSMutableAttributedString alloc] initWithString:@"　@不吃葱花教:很小的时候，没有适合自己的枕头，一直枕着母亲的手臂睡觉，一年又一年，那该有多难受...\n" attributes:@{
                                                                                                                                                            (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                            (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                            (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName:TN_ARC_BRIDGE textColor.CGColor,
                                                                                 (NSString *)                                                                           kCTParagraphStyleAttributeName: TN_ARC_BRIDGE style
                                                                                                                                                            }];
    
    
    NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"@张苏沛:初三的时候，晚上睡很晚，曾经一度晚上两三点才睡觉，当时没有电热毯，是我妈每天晚上先睡我床上为我暖被窝，等我写完作业，她才回她的房间睡。早上我一般是六点起床，我妈五点半就起来了，下楼给我买饭然后端上来给我吃，或者早起在家里自己给我做，从来没有塞给我几块钱让我下楼自己买。\n" attributes:@{
                                                                                                                                                                                                                                        (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                                                                                                        (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                                                                                                        (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName:TN_ARC_BRIDGE [UIColor greenColor].CGColor
                                                                                                                                                                                                                                        }];
    NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:@"@小亲亲:记得上大一的时候，有一次随手在QQ个签上写了一句“好想回家”，这件事我很快就忘记了。很久之后，跟妈妈说话的时候，她跟我说，看见我写的那句" attributes:@{
                                                                                                                                                                    (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                                    (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                                    (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName: TN_ARC_BRIDGE [UIColor blueColor].CGColor
                                                                                                                                                                    }];
    [att appendAttributedString:att1];
    [att appendAttributedString:att2];
    
    return att;
    
}

- (NSDictionary *)fontAttributes
{
    return @{
             (NSString *)kCTFontFamilyNameAttribute : @"Helvetica",
             };
}

@end
