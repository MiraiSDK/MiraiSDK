//
//  TNCTView.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCTView.h"
#import <CoreText/CoreText.h>

@implementation TNCTView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    
    // Font
    CGFloat fontSize = 20;
    
    NSDictionary *fontAttributes = [self fontAttributes];
    CTFontDescriptorRef fontDescRef = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)(fontAttributes));
    CTFontRef fontRef = CTFontCreateWithFontDescriptor(fontDescRef, fontSize, NULL);
    NSLog(@"fontDesc:%@",fontDescRef);
    
    NSString *actualFamilyName = (__bridge_transfer id)(CTFontCopyFamilyName(fontRef));
    NSString *expectFamilyName = fontAttributes[(NSString *)kCTFontFamilyNameAttribute];

    NSLog(@"font:%@",fontRef);
    NSLog(@"actualFamilyName:%@ expectFamilyName:%@",actualFamilyName,expectFamilyName);
    
    [self tryAttWithFontSize:18 context:ctx];
    
    
//    [self tryAttWithFontSize:30];
}

- (void)tryAttWithFontSize:(CGFloat)size context:(CGContextRef)ctx
{
    NSLog(@"will test font size %.0f",size);

    NSAttributedString *att = [self attributedStringWithFontSize:size];
    
    
    CGFloat width = self.bounds.size.width;
    width = 648;
    
    
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(att));

    // on android Next Book:104
    // correct shoule be: 53?
    CFIndex textCount = CTTypesetterSuggestLineBreak(typesetter, 0, width);
    NSLog(@"suggest at idx:0 with width:%f result:%d",width,textCount);

    
    
    NSLog(@"%@",[[att attributedSubstringFromRange:NSMakeRange(0, textCount)] string]);
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(0, textCount));

//    [[UIColor redColor] set];
    
//    CGContextSetTextPosition(ctx, 0, 50);
//    CTLineDraw(line, ctx);
    
//    textCount = CTTypesetterSuggestLineBreak(typesetter, 0, width/2);
//    NSLog(@"suggest at idx:0 with width:%f result:%d",width/2,textCount);
//    NSLog(@"%@",[[att attributedSubstringFromRange:NSMakeRange(0, textCount)] string]);
//
//    textCount = CTTypesetterSuggestLineBreak(typesetter, 50, width);
//    NSLog(@"suggest at idx:50 with width:%f result:%d",width,textCount);
//    NSLog(@"%@",[[att attributedSubstringFromRange:NSMakeRange(50, textCount)] string]);

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(att));
    CGRect bounds = self.bounds;
    bounds.origin.y = -300;
    bounds.size.width = width;
    
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(frame, ctx);
    
}

#if __ANDROID__
#define TN_ARC_BRIDGE
#else
#define TN_ARC_BRIDGE (__bridge id)
#endif
- (NSAttributedString *)attributedStringWithFontSize:(CGFloat)size
{
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)([self fontAttributes]));
    
    CTFontRef font = CTFontCreateWithFontDescriptor(desc, size, NULL);
    
    UIColor *color = [UIColor blueColor];
    
    NSMutableAttributedString *att= [[NSMutableAttributedString alloc] initWithString:@"　@不吃葱花教:很小的时候，没有适合自己的枕头，一直枕着母亲的手臂睡觉，一年又一年，那该有多难受...\n" attributes:@{
                                                                                                                                                            (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                            (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                            (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName:TN_ARC_BRIDGE [UIColor redColor].CGColor                                                          }];
    
    
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
