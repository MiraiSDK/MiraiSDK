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
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"jobs" withExtension:@"m4v"];
    MPMoviePlayerController *mpc = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.player = mpc;
    
    [self.view addSubview:mpc.view];
    
    [mpc play];
}


@end
