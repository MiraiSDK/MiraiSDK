//
//  TNWebViewDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNWebViewDemoViewController.h"

@interface TNWebViewDemoViewController ()

@end

@implementation TNWebViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [webView loadHTMLString:@"Hello world" baseURL:nil];
//    [webView loadHTMLString:@"<html><head></head> <body> Hello World</body> </html>" baseURL:nil];

}


@end
