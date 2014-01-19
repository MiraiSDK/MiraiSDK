//
//  UIScreen.h
//  UIKit
//
//  Created by Chen Yonghui on 12/7/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

@class UIScreenMode, CADisplayLink, UIView;

UIKIT_EXTERN NSString *const UIScreenDidConnectNotification;
UIKIT_EXTERN NSString *const UIScreenDidDisconnectNotification;
UIKIT_EXTERN NSString *const UIScreenModeDidChangeNotification;
UIKIT_EXTERN NSString *const UIScreenBrightnessDidChangeNotification;

typedef NS_ENUM(NSInteger, UIScreenOverscanCompensation) {
    UIScreenOverscanCompensationScale,
    UIScreenOverscanCompensationInsetBounds,
    UIScreenOverscanCompensationInsetApplicationFrame,
};


@interface UIScreen : NSObject
+ (NSArray *)screens;
+ (UIScreen *)mainScreen;

@property(nonatomic,readonly) CGRect  bounds;
@property(nonatomic,readonly) CGRect  applicationFrame;
@property(nonatomic,readonly) CGFloat scale;


@property(nonatomic,readonly,copy) NSArray *availableModes;
@property(nonatomic,readonly,retain) UIScreenMode *preferredMode;
@property(nonatomic,retain) UIScreenMode *currentMode;
@property(nonatomic) UIScreenOverscanCompensation overscanCompensation;
@property(nonatomic,readonly,retain) UIScreen *mirroredScreen;
@property(nonatomic) CGFloat brightness;
@property(nonatomic) BOOL wantsSoftwareDimming;
- (CADisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel;

@end

/* iOS 7 API
@interface UIScreen (UISnapshotting)
- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;
@end
 */
