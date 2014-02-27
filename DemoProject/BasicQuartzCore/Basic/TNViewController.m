//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <CoreText/CoreText.h>

@interface TNViewController ()

@end

@implementation TNViewController

- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"Action" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(50, 100, 100, 50)];
    
    [self.view addSubview:button];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"jpg"];
    NSLog(@"imagePath:%@",imagePath);
    
    CGDataProviderRef imageSource = CGDataProviderCreateWithFilename([imagePath UTF8String]);
    CGImageRef imageRef = CGImageCreateWithJPEGDataProvider(imageSource, NULL, NO, kCGRenderingIntentDefault);
    UIImage *i = [[UIImage alloc] initWithCGImage:imageRef];
    NSLog(@"%@",i);
    
    NSString *pngImagePath = [[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];
    NSLog(@"imagePath:%@",pngImagePath);
    if (pngImagePath) {
        CGDataProviderRef pngSource = CGDataProviderCreateWithFilename([pngImagePath UTF8String]);
        CGImageRef pngImageRef = CGImageCreateWithPNGDataProvider(pngSource, NULL, NO, kCGRenderingIntentDefault);
        UIImage *pngImage = [[UIImage alloc] initWithCGImage:pngImageRef];
        NSLog(@"png: %@",pngImage);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:pngImage];
        imageView.frame = CGRectMake(0, 0, 100, 100);
        [self.view addSubview:imageView];
        
    }
    
    UIView *s = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    s.backgroundColor = [UIColor redColor];
    [self.view addSubview:s];
    
}

//- (void)showAlert:(id)sender
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidAppear:animated];
}

@end
