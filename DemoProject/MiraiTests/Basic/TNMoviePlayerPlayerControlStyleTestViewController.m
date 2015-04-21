//
//  TNMoviePlayerPlayerControlStyleTestViewController.m
//  MiraiTests
//
//  Created by TaoZeyu on 15/4/21.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMoviePlayerPlayerControlStyleTestViewController.h"
#import "TNMediaPlayerTestUitil.h"
#import <MediaPlayer/MediaPlayer.h>

typedef int (^ActionBlock)(void);

@interface TNMoviePlayerPlayerControlStyleTestViewController ()
@property NSDictionary *titleToActionBlockDictionary;
@property NSUInteger hasGenerateButtonCount;
@end

@implementation TNMoviePlayerPlayerControlStyleTestViewController

+ (NSString *)testName
{
    return @"Controll Style Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _makeChooseStyleButtonList];
}

- (void)_makeChooseStyleButtonList
{
    self.hasGenerateButtonCount = 0;
    
    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [self _generateButtonWithName:@"None" withStyle:MPMovieControlStyleNone withContainer:container];
    [self _generateButtonWithName:@"Default" withStyle:MPMovieControlStyleDefault withContainer:container];
    [self _generateButtonWithName:@"Embeded" withStyle:MPMovieControlStyleEmbedded withContainer:container];
    [self _generateButtonWithName:@"Fullscreen" withStyle:MPMovieControlStyleFullscreen withContainer:container];
    
    self.titleToActionBlockDictionary = [[NSDictionary alloc] initWithDictionary:container];
}

- (void)_generateButtonWithName:(NSString *)buttonName withStyle:(MPMovieControlStyle)style withContainer:(NSMutableDictionary *)container
{
    UIButton *button = [self _createButtonAndAddToSubviewWithTitle:buttonName];
    [button addTarget:self action:@selector(_onClickStyleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    [container setObject:^{
        weakSelf.player.controlStyle = style;
    } forKey:buttonName];
}

- (UIButton *)_createButtonAndAddToSubviewWithTitle:(NSString *)buttonName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, self.buttonStartLocation + 40*self.hasGenerateButtonCount, 100, 35);
    [button setTitle:buttonName forState:UIControlStateNormal];
    [self.view addSubview:button];
    self.hasGenerateButtonCount++;
    return button;
}

- (void)_onClickStyleButton:(id)sender
{
    UIButton *clickedButton = sender;
    NSString *title = [clickedButton titleForState:UIControlStateNormal];
    ActionBlock actionBlock = [self.titleToActionBlockDictionary objectForKey:title];
    actionBlock();
}

@end
