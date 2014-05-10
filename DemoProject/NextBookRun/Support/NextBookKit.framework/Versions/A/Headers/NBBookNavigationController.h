//
//  NBBookNavigationController.h
//  NextBook
//
//  Created by Chen Yonghui on 2/22/13.
//  Copyright (c) 2013 Shanghai TinyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBBookNavigationControllerDelegate;
@class NBBook;
@class NBBookViewController;

@interface NBBookNavigationController : UINavigationController
- (id)initWithContentViewController:(NBBookViewController *)contentViewController;

@property (nonatomic, weak) id<NBBookNavigationControllerDelegate> bookNaviDelegate;
@property (nonatomic, strong, readonly) NBBookViewController *bookViewController;
@property (nonatomic, strong, readonly) NBBook *book;
@property (nonatomic, strong, readonly) NSIndexPath *displayedIndexPath;

-(void) updateNavigationControllerRightBarButtonItems;

- (void)setDisplayPageAtIndexPath:(NSIndexPath *)indexPath;

/*!
 *  @abstract should auto record read postion
 *  @property shouldAutoRecordReadPosition
 *
 *  @discussion
 *  if YES, NavigationController will auto record read position and auto set display page for next open.
 *  Set NO to disable this feature.
 *  Default is YES
 */
@property (nonatomic, assign) BOOL shouldAutoRecordReadPosition;

/*!
 *  @abstract enable Notes Feature
 *  @property notesFeatureEnabled
 *
 *  @discussion
 *  Default is NO
 */
@property (nonatomic, assign) BOOL notesFeatureEnabled;

/*!
 *  @abstract enable Scale Feature
 *  @property scaleFeatureEnabled
 *
 *  @discussion
 *  Default is NO
 */

@property (nonatomic, assign) BOOL scaleFeatureEnabled;


@end

@protocol NBBookNavigationControllerDelegate <NSObject>
@optional
- (void)bookNavigationControllerDidCancel:(NBBookNavigationController *)controller;

- (void)bookNavigationController:(NBBookNavigationController *)controller didDisplayPageAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)rightBarButtonItemsForNavigationController:(NBBookNavigationController *) controller;

- (void)bookNavigationController:(NBBookNavigationController *)controller didOccurEventWithInfomation:(NSDictionary *)info;
@end
