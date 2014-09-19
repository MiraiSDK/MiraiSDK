//
//  TNPresentTestViewController.h
//  MiraiTests
//
//  Created by Chen Yonghui on 9/17/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTestViewController.h"

@protocol TNPresentTestViewControllerDelegate;

@interface TNPresentTestViewController : TNTestViewController
@property (nonatomic, weak) id<TNPresentTestViewControllerDelegate> delegate;
@end

@protocol TNPresentTestViewControllerDelegate <NSObject>

- (void)presentTestViewControllerDidCancel:(TNPresentTestViewController *)vc animated:(BOOL)animated;

@end