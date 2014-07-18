//
//  TNPresentedContentViewController.h
//  BasicCairo
//
//  Created by Chen Yonghui on 7/18/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TNPresentedContentViewControllerDelegate;

@interface TNPresentedContentViewController : UIViewController
@property (nonatomic, weak) id <TNPresentedContentViewControllerDelegate> delegate;

@end

@protocol TNPresentedContentViewControllerDelegate <NSObject>

- (void)presentedContentViewControllerDidCancel:(TNPresentedContentViewController *)vc animated:(BOOL)animated;

@end
