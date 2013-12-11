//
//  UIGraphics.h
//  UIKit
//
//  Created by Chen Yonghui on 12/7/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

@class UIImage;

UIKIT_EXTERN CGContextRef UIGraphicsGetCurrentContext(void);
UIKIT_EXTERN void UIGraphicsPushContext(CGContextRef context);
UIKIT_EXTERN void UIGraphicsPopContext(void);

//UIKIT_EXTERN void UIRectFillUsingBlendMode(CGRect rect, CGBlendMode blendMode);
//UIKIT_EXTERN void UIRectFill(CGRect rect);
//
//UIKIT_EXTERN void UIRectFrameUsingBlendMode(CGRect rect, CGBlendMode blendMode);
//UIKIT_EXTERN void UIRectFrame(CGRect rect);
//
//UIKIT_EXTERN void UIRectClip(CGRect rect);

// UIImage context

UIKIT_EXTERN void     UIGraphicsBeginImageContext(CGSize size);
UIKIT_EXTERN void     UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
UIKIT_EXTERN UIImage* UIGraphicsGetImageFromCurrentImageContext(void);
UIKIT_EXTERN void     UIGraphicsEndImageContext(void);

// PDF context

//UIKIT_EXTERN BOOL UIGraphicsBeginPDFContextToFile(NSString *path, CGRect bounds, NSDictionary *documentInfo);
//UIKIT_EXTERN void UIGraphicsBeginPDFContextToData(NSMutableData *data, CGRect bounds, NSDictionary *documentInfo);
//UIKIT_EXTERN void UIGraphicsEndPDFContext(void);
//
//UIKIT_EXTERN void UIGraphicsBeginPDFPage(void);
//UIKIT_EXTERN void UIGraphicsBeginPDFPageWithInfo(CGRect bounds, NSDictionary *pageInfo);
//
//UIKIT_EXTERN CGRect UIGraphicsGetPDFContextBounds(void);
//
//UIKIT_EXTERN void UIGraphicsSetPDFContextURLForRect(NSURL *url, CGRect rect);
//UIKIT_EXTERN void UIGraphicsAddPDFContextDestinationAtPoint(NSString *name, CGPoint point);
//UIKIT_EXTERN void UIGraphicsSetPDFContextDestinationForRect(NSString *name, CGRect rect);

