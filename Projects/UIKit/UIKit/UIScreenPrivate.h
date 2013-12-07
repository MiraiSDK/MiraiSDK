//
//  UIScreenPrivate.h
//  UIKit
//
//  Created by Chen Yonghui on 12/7/13.
//  Copyright (c) 2013 Shanghai Tinynetwork Inc. All rights reserved.
//

#import <UIKit/UIScreen.h>
#include <android/native_window.h>

@interface UIScreen ()
- (instancetype)initWithAndroidNativeWindow:(ANativeWindow *)window;
@end

