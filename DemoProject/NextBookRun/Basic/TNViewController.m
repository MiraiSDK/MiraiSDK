//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <QuartzCore/QuartzCore.h>

#import <NextBookKit/NextBookKit.h>
#import <dispatch/dispatch.h>

#import "TNSecondViewController.h"

@interface TNViewController ()
@property (nonatomic, strong) NBBook *book;
@end

@implementation TNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Load Book" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    CGRect f = button.frame;
    f.origin = CGPointMake(50, 50);
    button.frame = f;
    [self.view addSubview:button];
    
    [NBBookLib authWithDeveloperID:@"" key:@""];
}

- (NSString *)bookPath
{
    //return [[NSBundle mainBundle] pathForResource:@"Untitled" ofType:@"ibooks"];
    return [[NSBundle mainBundle] pathForResource:@"Simple" ofType:@"ibooks"];
}
- (void)didPressedButton:(id)sender
{
    NSString *path = [self bookPath];
    NSLog(@"book path:%@",path);
    
//    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"Simple1" ofType:@"ibooks"];
//    NSLog(@"Simple1 path:%@",path1);

    if (path) {
        NSLog(@"will init book");
        NBBook *book = [[NBBook alloc] initWithContentsOfFile:path];
        NSLog(@"book:%@",book);
        
        if ([book isReadyForOpen]) {
            NSLog(@"book:%@",book);
            NSLog(@"title:%@ chapters:%@",book.bookTitle,book.chapters);
            NBBookViewController *vc = [[NBBookViewController alloc] initWithBook:book];
            [self presentViewController:vc animated:YES completion:nil];

        } else {
            
            [book prepareForOpenOnProcessing:^(NSInteger idx, NSInteger total) {
                NSLog(@"Book loading %d/%d",idx,total);
            } onCompletion:^(NBBook *book) {
                NSLog(@"prepare completion.");
                NSLog(@"book:%@",book);
                NSLog(@"title:%@ chapters:%@",book.bookTitle,book.chapters);
                NBBookViewController *vc = [[NBBookViewController alloc] initWithBook:book];
                
                //            NBBookNavigationController *nav = [[NBBookNavigationController alloc] initWithContentViewController:vc];
                [self presentViewController:vc animated:YES completion:nil];
            }];
        }
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
