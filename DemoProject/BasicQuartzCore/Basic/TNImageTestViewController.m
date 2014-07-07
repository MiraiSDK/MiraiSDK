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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    [self addImageWithName:@"testImage" type:@"png" atRect:CGRectMake(0, 0, 720, 1024)];
    
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"jpg"];
    //    NSLog(@"imagePath:%@",imagePath);
    //
    //    CGDataProviderRef imageSource = CGDataProviderCreateWithFilename([imagePath UTF8String]);
    //    CGImageRef imageRef = CGImageCreateWithJPEGDataProvider(imageSource, NULL, NO, kCGRenderingIntentDefault);
    //    UIImage *i = [[UIImage alloc] initWithCGImage:imageRef];
    //    NSLog(@"%@",i);
    //
    //    [self addImageWithName:@"rgbatest" type:@"png" atRect:CGRectMake(0, 0, 720, 720)];
    
    //    [self addImageWithName:@"Icon" type:@"png" atRect:CGRectMake(50, 600, 72, 72)];

    //    [self addImageWithName:@"Icon" type:@"png" atRect:CGRectMake(50, 600, 72, 72)];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    [self testImageWithData];
    
    self.title = [[self class] testName];
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

- (CGImageRef)createImageNamed:(NSString *)name type:(NSString *)type
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    CGImageRef image = NULL;
    if (imagePath) {
        NSString *lowercaseType = [type lowercaseString];
        CGDataProviderRef source = CGDataProviderCreateWithFilename([imagePath UTF8String]);
        if ([lowercaseType isEqualToString:@"png"]) {
            image = CGImageCreateWithPNGDataProvider(source, NULL, NO, kCGRenderingIntentDefault);
        } else if ([lowercaseType isEqualToString:@"jpg"]) {
            image = CGImageCreateWithJPEGDataProvider(source, NULL, NO, kCGRenderingIntentDefault);
        } else {
            NSLog(@"unsupported image type:%@",type);
        }
        
    } else {
        NSLog(@"[WARNING]Can't find file: %@.%@",name,type);
    }
    return image;
}

- (void)addImageWithName:(NSString *)name type:(NSString *)type atRect:(CGRect)rect
{
    CGImageRef imageRef = [self createImageNamed:name type:type];
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = rect;
    
    [self.view addSubview:imageView];
}

@end
