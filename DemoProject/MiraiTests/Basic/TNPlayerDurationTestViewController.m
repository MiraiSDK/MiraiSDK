//
//  TNPlayerDurationTestViewController.m
//  MiraiTests
//
//  Created by TaoZeyu on 15/4/26.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPlayerDurationTestViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>

@interface TNPlayerDurationTestViewController()
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *playableDurationLabel;
@end

@implementation TNPlayerDurationTestViewController

+ (NSString *)testName
{
    return @"Player Duration Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _makeInfomationText];
    [self _makeButtons];
}

- (void)_makeInfomationText
{
    self.durationLabel = [[UILabel alloc] initWithFrame:
                                  CGRectMake(5, self.buttonStartLocation, 300, 23)];
    self.playableDurationLabel = [[UILabel alloc] initWithFrame:
                                  CGRectMake(5, self.buttonStartLocation + 25, 300, 23)];
    
    [self.durationLabel setText:@"Duration : wait for refresh."];
    [self.playableDurationLabel setText:@"PlayableDuration : wait for refresh."];
    
    [self.view addSubview:self.durationLabel];
    [self.view addSubview:self.playableDurationLabel];
}

- (void)_makeButtons
{
    [self _makeButtonWithTitle:@"refresh infomation" action:@selector(_onTapRefreshInfomationButton:) at:100];
    [self _makeButtonWithTitle:@"set fullscreen" action:@selector(_onTapFullscreenButton:) at:135];
}

- (UIButton *)_makeButtonWithTitle:(NSString *)title action:(SEL)selector at:(CGFloat)location
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(5, self.buttonStartLocation + location, 180, 30);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)_onTapRefreshInfomationButton:(id)sender
{
    [self.durationLabel setText:[NSString stringWithFormat:@"Duration : %f", self.player.duration]];
    [self.playableDurationLabel setText:[NSString stringWithFormat:@"PlayableDuration : %f", self.player.playableDuration]];
}

- (void)_onTapFullscreenButton:(id)sender
{
    [self.player setControlStyle:MPMovieControlStyleFullscreen];
}

@end
