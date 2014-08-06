//
//  TNTestViewController.h
//  BasicCairo
//
//  Created by Chen Yonghui on 4/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNTestViewController : UIViewController
+ (NSString *)testName;
- (NSString *)testDescription;

+ (NSArray *)tests;
+ (void)regisiterTestClass:(Class)cls;

+ (NSArray *)subTests;
@end
