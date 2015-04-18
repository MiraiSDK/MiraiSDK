//
//  TNMediaPlayerTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/25/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMediaPlayerTestViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TNMediaPlayerTestViewController ()
@property (nonatomic ,strong) MPMoviePlayerController *player;
@end

@implementation TNMediaPlayerTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Media Player Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Load" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadMovie:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = CGPointMake(button.frame.size.width/2, 800);
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Pause" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    button1.center = CGPointMake(CGRectGetMaxX(button.frame) + button1.bounds.size.width/2 + 10, button.center.y);
    [self.view addSubview:button1];
    
    UIBarButtonItem *pauseItem = [[UIBarButtonItem alloc] initWithTitle:@"pause" style:UIBarButtonItemStylePlain target:self action:@selector(pause:)];
    UIBarButtonItem *loadItem = [[UIBarButtonItem alloc] initWithTitle:@"load" style:UIBarButtonItemStylePlain target:self action:@selector(loadMovie:)];
    UIBarButtonItem *playItem = [[UIBarButtonItem alloc] initWithTitle:@"play" style:UIBarButtonItemStylePlain target:self action:@selector(play:)];
    
    self.navigationItem.rightBarButtonItems = @[pauseItem,loadItem,playItem];
}

- (void)pause:(id)sender
{
    [self.player pause];
}

- (void)play:(id)sender
{
    [self.player play];
}

- (void)loadMovie:(id)sender
{
    if (self.player) {
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"jobs" withExtension:@"m4v"];
//    if (!url) {
//        NSURL *document = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//        url = [document URLByAppendingPathComponent:@"jobs.m4v"];
    //    }
    NSURL *url = [self _getAssetUrlFromAbsolutePath];
    MPMoviePlayerController *mpc = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.player = mpc;
    
    [self.view addSubview:mpc.view];
    
    [mpc play];
}

- (NSURL *)_getAssetUrlFromAbsolutePath
{
    return [[NSURL alloc] initWithString:@"file://localhost/storage/emulated/legacy/Android/data/org.tiny4.MiraiTests/org.tiny4.MiraiTests.app/funnydog.mp4"];
}

@end
