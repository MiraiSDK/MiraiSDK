//
//  TNWebViewTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 10/18/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNWebViewTestViewController.h"

@interface TNWebViewTestViewController ()

@end

@implementation TNWebViewTestViewController
{
    UIWebView *_webView;
}

+ (NSString *)testName
{
    return @"UIWebView";
}

+ (void)load
{
    [self regisiterTestClass:self];
}

- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, 600, 800)];
    [self.view addSubview:web];
    _webView = web;
    
    [web loadHTMLString:@"<html><head></head> <body> Hello World <a href=\"https://play.google.com/store/apps/details?id=com.dynadream.uFall\">Download uFall</a><p>Line 1</p><p>Line 2</p><p>Line3</p></body> </html>" baseURL:nil];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"LoadURL" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [button1 sizeToFit];
    button1.center = CGPointMake(100, 900);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"loadString" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [button2 sizeToFit];
    button2.center = CGPointMake(300, 900);
    [self.view addSubview:button2];
    
}

- (void)button1Pressed:(id)sender
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [_webView loadRequest:request];
}

- (void)button2Pressed:(id)sender
{
    [_webView loadHTMLString:@"<html><head></head> <body> Hello World <a href=\"https://play.google.com/store/apps/details?id=com.dynadream.uFall\">Download uFall</a><p>Line 1</p><p>Line 2</p><p>Line3</p></body> </html>" baseURL:nil];

}

@end
