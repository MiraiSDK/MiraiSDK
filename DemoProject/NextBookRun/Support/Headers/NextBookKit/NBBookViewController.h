//
//  NBBookViewController.h
//  NextBook
//
//  Created by Chen Yonghui on 12/26/12.
//  Copyright (c) 2012 Shanghai TinyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBBook;
@protocol NBBookViewControllerDelegate;

@interface NBBookViewController : UIViewController
- (id)initWithBook:(NBBook *)book;

@property (nonatomic, strong) NBBook *book;
@property (nonatomic, strong, readonly) NSIndexPath *displayedIndexPath;
@property (nonatomic, weak) id<NBBookViewControllerDelegate> delegate;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

-(UIImage *) currentDisplayedPageViewFullScreenImageInBookVC;

- (void)setDisplayPageAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)setFreezingScroll:(BOOL)freezing;
@end


@protocol NBBookViewControllerDelegate <NSObject>

-(void) bookViewController:(NBBookViewController *) bookViewController didStopGestureToShowThumbnail:(BOOL) shouldShowThumbnail scale:(CGFloat)scale;
-(void) startGesturebookViewController:(NBBookViewController *) bookViewController;
-(void) bookViewControllerChangeToChapterNum:(int) chapterNum;

@optional
- (void)bookViewController:(NBBookViewController *)vc didScale:(CGFloat)scale;

-(void) bookViewController:(NBBookViewController *) bookViewController didStopGestureToShowThumbnail:(BOOL) shouldShowThumbnail __attribute((deprecated("use -bookViewController:didStopGestureToShowThumbnail:scale: method")));

@end


extern NSString *const NBTocDidShowNotification;
extern NSString *const NBTocDidHideNotification;