//
//  TNAbstractMediaPlayerTestViewController.m
//  MiraiTests
//
//  Created by TaoZeyu on 15/4/26.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAbstractMediaPlayerTestViewController.h"
#import "TNMediaPlayerTestUitil.h"

#define TopDistanceOfPlayer 100
#define BottomDistanceOfPlayer 10

@interface TNAbstractMediaPlayerTestViewController ()
@property (nonatomic, strong) MPMoviePlayerController *player;
@end

@implementation TNAbstractMediaPlayerTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _makeDisplayBarButtonItem];
}

- (CGFloat)buttonStartLocation
{
    return 0.8*self.view.bounds.size.width + TopDistanceOfPlayer + BottomDistanceOfPlayer;
}

- (void)_makeDisplayBarButtonItem
{
    UIBarButtonItem *displayItem = [[UIBarButtonItem alloc] initWithTitle:@"Display" style:UIBarButtonItemStylePlain target:self action:@selector(_onClickDisplay:)];
    self.navigationItem.rightBarButtonItems = @[displayItem];
}

- (void)_onClickDisplay:(id)sender
{
    [self _resetPlayer];
    [self.player play];
}

- (void)_resetPlayer
{
    [self _clearOldPlayerIfExist];
    self.player = [self _createNewPlayer];
    [self.view addSubview:self.player.view];
}

- (void)_clearOldPlayerIfExist
{
    if (self.player) {
        [self.player stop];
        [self.player.view removeFromSuperview];
    }
}

- (MPMoviePlayerController *)_createNewPlayer
{
    NSURL *url = [TNMediaPlayerTestUitil URLWithResourceName:@"funnydog" withExtension:@"mp4"];
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    player.view.frame = CGRectMake(5, TopDistanceOfPlayer, self.view.bounds.size.width, 0.8*self.view.bounds.size.width);
    return player;
}

@end
