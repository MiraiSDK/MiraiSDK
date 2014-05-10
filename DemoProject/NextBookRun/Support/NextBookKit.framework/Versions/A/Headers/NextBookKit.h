//
//  NextBookKit.h
//  NextBook
//
//  Created by Chen Yonghui on 3/5/13.
//  Copyright (c) 2013 Shanghai TinyNetwork. All rights reserved.
//

#ifndef NextBook_NextBookKit_h
#define NextBook_NextBookKit_h

#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#else
//#import <Cocoa/Cocoa.h>

#import <Foundation/Foundation.h>
//#import <AppKit/AppKit.h>
#import <UIKit/UIKit.h>
//#import "Defines-Mac.h"
#endif

#import "NBBookLib+Auth.h"

#import "NBBook.h"

#import "NBBookViewController.h"

#import "NBBookNavigationController.h"
#if TARGET_OS_IPHONE
#import "NBBrowserViewController.h"
#endif

#endif
