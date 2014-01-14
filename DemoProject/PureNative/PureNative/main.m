//
//  main.m
//  PureNative
//
//  Created by Chen Yonghui on 1/12/14.
//  Copyright (c) 2014 Shanghai TinyNetwork Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#import "AppDelegate.h"
#include <stdio.h>

#undef main

@interface PNHelper : NSObject

@end
@implementation PNHelper{
    NSAttributedString *_attributedString;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)test
{
//    CGRect rect = CGRectMake(0, 0, 100, 100);
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(_attributedString));
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, rect);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
//    CGPathRelease(path);
    
    printf("will create Roboto\n");
    CGFontRef f1 = CGFontCreateWithFontName(@"Roboto");
    printf("result: %s\n",f1?"YES":"NULL");
    

}

- (NSDictionary *)attributes
{
    CGColorRef redColor = CGColorCreateGenericRGB(1, 0, 0, 1);
    CGFontRef font = CGFontCreateWithFontName(@"Arial");
    return @{
             kCTForegroundColorAttributeName:(id)redColor,
             //(__bridge NSString *)kCTFontAttributeName:font
             };
}


@end

int main(int argc, char * argv[])
{
    printf("main\n");

    printf("will initialize process info\n");

    [NSProcessInfo initializeWithArguments:argv count:argc environment:NULL];
    
    @autoreleasepool {
        printf("enter autorelease pool\n");
        
        PNHelper *h = [[PNHelper alloc] init];
        [h test];
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

    }
    return 0;
}
