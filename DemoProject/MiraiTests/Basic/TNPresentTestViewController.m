//
//  TNPresentTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 9/17/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPresentTestViewController.h"

@interface TNPresentTestViewController () <TNPresentTestViewControllerDelegate>
@property (nonatomic, strong) UIView *tl;
@property (nonatomic, strong) UIView *tr;
@property (nonatomic, strong) UIView *bl;
@property (nonatomic, strong) UIView *br;

@property (nonatomic, strong) UIView *area;

@property (nonatomic, assign) CGFloat resizeMarkLength;
@property (nonatomic, strong) NSArray *testcases;

@property (nonatomic, strong) UILabel *orientationLabel;

@property (nonatomic, assign) NSUInteger orientation;

@end

@implementation TNPresentTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.resizeMarkLength = 20;
        self.orientation = UIInterfaceOrientationMaskAll;
        self.testcases = @[
                           [TNTestCase testCaseWithName:@"Portrait" action:^{
                               [weakSelf presentContentWithOrientation:UIInterfaceOrientationMaskPortrait];
                           }],
                           [TNTestCase testCaseWithName:@"Landscape" action:^{
                               [weakSelf presentContentWithOrientation:UIInterfaceOrientationMaskLandscape];
                           }],
                           [TNTestCase testCaseWithName:@"All" action:^{
                               [weakSelf presentContentWithOrientation:UIInterfaceOrientationMaskAll];
                           }],
                           [TNTestCase testCaseWithName:@"Dismiss" action:^{
                               [weakSelf.delegate presentTestViewControllerDidCancel:weakSelf animated:NO];
                           }],
                           
                           [TNTestCase testCaseWithName:@"Dismiss animated" action:^{
                               [weakSelf.delegate presentTestViewControllerDidCancel:weakSelf animated:YES];
                           }],
                           [TNTestCase testCaseWithName:@"set view frame to main screen bounds" action:^{
                               weakSelf.view.frame = [[UIScreen mainScreen] bounds];
                           }],
                           [TNTestCase testCaseWithName:@"log navigation subviews" action:^{
//                               NSLog(@"se");
                               NSLog(@"%@",weakSelf.navigationController.view.subviews);
                           }]
                           ];
    }
    return self;
}

- (void)presentContentWithOrientation:(NSUInteger)orientation
{
    TNPresentTestViewController *vc = [[TNPresentTestViewController alloc] init];
    vc.delegate = self;
    vc.orientation = orientation;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)presentTestViewControllerDidCancel:(TNPresentTestViewController *)vc animated:(BOOL)animated;
{
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat resizeMarkLength = self.resizeMarkLength;
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    
    UIView *tl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, resizeMarkLength, resizeMarkLength)];
    tl.backgroundColor = [UIColor redColor];
    [self.view addSubview:tl];
    self.tl = tl;

    UIView *tr = [[UIView alloc] initWithFrame:CGRectMake(viewWidth - resizeMarkLength, 0,
                                                          resizeMarkLength, resizeMarkLength)];
    tr.backgroundColor = [UIColor greenColor];
    [self.view addSubview:tr];
    tr.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    self.tr = tr;

    UIView *bl = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight - resizeMarkLength,
                                                          resizeMarkLength, resizeMarkLength)];
    bl.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bl];
    self.bl = bl;

    UIView *br = [[UIView alloc] initWithFrame:CGRectMake(viewWidth - resizeMarkLength,viewHeight - resizeMarkLength,
                                                          resizeMarkLength, resizeMarkLength)];
    br.backgroundColor = [UIColor blackColor];
    [self.view addSubview:br];
    self.br = br;

    
    UIView *buttonArea = [[UIView alloc] initWithFrame:CGRectMake(resizeMarkLength,
                                                                  resizeMarkLength + self
                                                                  .navigationController.navigationBar.bounds.size.height,
                                                                  viewWidth - resizeMarkLength * 2,
                                                                  viewHeight - resizeMarkLength * 2 - self
                                                                  .navigationController.navigationBar.bounds.size.height)];
    if (!self.presentingViewController) {
        buttonArea.backgroundColor = [UIColor lightGrayColor];
    } else {
        CGFloat hue = (arc4random() % 100) / 100.0;
        buttonArea.backgroundColor = [UIColor colorWithHue:hue saturation:hue brightness:1 alpha:1];
    }
    
    [self.view addSubview:buttonArea];
    self.area = buttonArea;
    
    __block CGFloat y = 0;
    [self.testcases enumerateObjectsUsingBlock:^(TNTestCase *tc, NSUInteger idx, BOOL *stop) {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [button1 setTitle:tc.name forState:UIControlStateNormal];
        [button1 sizeToFit];
        button1.center = CGPointMake(buttonArea.bounds.size.width/2, button1.bounds.size.height/2 + y);
        button1.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        button1.tag = idx;
        [button1 addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArea addSubview:button1];
        
        y += button1.bounds.size.height;
    }];

    
    UILabel *ol = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonArea.bounds.size.width, 200)];
    ol.numberOfLines = 0;
    [buttonArea addSubview:ol];
    self.orientationLabel = ol;
    
    if (self.presentingViewController) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didPressedCancelItem:)];
        self.navigationItem.leftBarButtonItems = @[left];        
    }
}

- (void)didPressedCancelItem:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentTestViewControllerDidCancel:animated:)]) {
        [self.delegate presentTestViewControllerDidCancel:self animated:YES];
    }
}

- (void)didPressedButton:(UIButton *)button
{
    TNTestCase *tc = self.testcases[button.tag];
    tc.action();
}

- (void)viewDidLayoutSubviews
{
    CGFloat resizeMarkLength = self.resizeMarkLength;
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);

    self.tl.frame = CGRectMake(0, 0, resizeMarkLength, resizeMarkLength);
    self.tr.frame = CGRectMake(viewWidth - resizeMarkLength, 0,resizeMarkLength, resizeMarkLength);
    self.bl.frame = CGRectMake(0, viewHeight - resizeMarkLength,
                               resizeMarkLength, resizeMarkLength);
    self.br.frame = CGRectMake(viewWidth - resizeMarkLength,
                               viewHeight - resizeMarkLength,
                               resizeMarkLength,
                               resizeMarkLength);
    
    self.area.frame = CGRectMake(resizeMarkLength,
                                 resizeMarkLength + self
                                 .navigationController.navigationBar.bounds.size.height,
                                 viewWidth - resizeMarkLength * 2,
                                 viewHeight - resizeMarkLength * 2 - self
                                 .navigationController.navigationBar.bounds.size.height);
    
    self.orientationLabel.text = [self orientationDescription];
    [self.orientationLabel sizeToFit];
    self.orientationLabel.center = CGPointMake(CGRectGetMidX(self.area.bounds),
                                               CGRectGetMaxY(self.area.bounds) - CGRectGetHeight(self.orientationLabel.bounds)/2);
}

- (NSString *)orientationDescription
{
    BOOL supportPortrait =  self.orientation & UIInterfaceOrientationMaskPortrait;
    BOOL supportLandscape = self.orientation & UIInterfaceOrientationMaskLandscape;
    return [NSString stringWithFormat:@"      Portrait: %@      \nLandscape: %@      ",supportPortrait?@"YES":@"NO",supportLandscape?@"YES":@"NO"];
    return nil;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return _orientation;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
