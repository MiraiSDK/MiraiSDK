//
//  TNAbstractMediaPlayerTestViewController.h
//  MiraiTests
//
//  Created by TaoZeyu on 15/4/26.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTestViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TNAbstractMediaPlayerTestViewController : TNTestViewController
@property (nonatomic, readonly) MPMoviePlayerController *player;
- (CGFloat)buttonStartLocation;
@end
