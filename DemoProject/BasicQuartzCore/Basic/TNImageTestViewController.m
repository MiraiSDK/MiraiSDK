//
//  TNImageTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 4/8/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNImageTestViewController.h"

@interface TNImageTestViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TNImageTestViewController
+ (NSString *)testName
{
    return @"Image Test";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    [self testImageWithData];
}

- (NSString *)jpegImagePath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"jpg"];
    NSLog(@"path:%@",path);
    return path;
}

- (NSString *)pngImagePath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"png"];
    NSLog(@"path:%@",path);
    return path;
}

- (NSData *)jpegImageData
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self jpegImagePath]];
    return data;
}

- (NSData *)pngImageData
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self pngImagePath]];
    return data;
}

- (void)testImageWithData
{
    
//    NSLog(@"create from path");
//    UIImage *pathImage = [UIImage imageWithContentsOfFile:[self jpegImagePath]];
//    NSLog(@"jpetImageFromPath:%@",pathImage);

    NSLog(@"create from data");
    NSData *jpegData = [self jpegImageData];
    UIImage *jpegImage = [UIImage imageWithData:jpegData];
//
    NSLog(@"jpegImage from data:%@",jpegImage);
    
//    NSLog(@"png image from path");
//    UIImage *pathPngImage = [UIImage imageWithContentsOfFile:[self pngImagePath]];
//    NSLog(@"png from Path:%@",pathPngImage);
    
//    NSData *pngData = [self pngImageData];
//    NSLog(@"pngData:%@",pngData);
//    UIImage *pngImage = [UIImage imageWithData:pngData];
//    
//    NSLog(@"pngImage:%@",pngImage);
    
    self.imageView.image = jpegImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
