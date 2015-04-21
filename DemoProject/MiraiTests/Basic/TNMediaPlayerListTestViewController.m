//
//  TNMediaPlayerListTestViewController.m
//  MiraiTests
//
//  Created by TaoZeyu on 15/4/21.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMediaPlayerListTestViewController.h"
#import "TNMediaPlayerTestViewController.h"
#import "TNMoviePlayerPlayerControlStyleTestViewController.h"
#import "TNPlayerDurationTestViewController.h"

@implementation TNMediaPlayerListTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Media Player Test";
}

- (NSArray *)subTests
{
    return @[
             TNMediaPlayerTestViewController.class,
             TNMoviePlayerPlayerControlStyleTestViewController.class,
             TNPlayerDurationTestViewController.class,
             ];
}

@end
