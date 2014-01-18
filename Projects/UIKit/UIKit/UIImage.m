//
//  UIImage.m
//  UIKit
//
//  Created by Chen Yonghui on 1/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork Inc. All rights reserved.
//

#import "UIImage.h"
@interface UIImage ()
@property (nonatomic, strong) CGImageRef imageRef;


@end

@implementation UIImage
@synthesize size = _size;
@synthesize scale = _scale;
@synthesize imageOrientation = _imageOrientation;

@synthesize images = _images;
@synthesize duration = _duration;

@synthesize capInsets = _capInsets;
@synthesize resizingMode = _resizingMode;

@synthesize alignmentRectInsets = _alignmentRectInsets;
@synthesize renderingMode = _renderingMode;

+ (UIImage *)imageNamed:(NSString *)name
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

+ (UIImage *)imageWithContentsOfFile:(NSString *)path
{
    return [[self alloc] initWithContentsOfFile:path];
}

+ (UIImage *)imageWithData:(NSData *)data
{
    return [[self alloc] initWithData:data];
}

+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale
{
    return [[self alloc] initWithData:data scale:scale];
}

+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage
{
    return [[self alloc] initWithCGImage:cgImage];
}

+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    return [[self alloc] initWithCGImage:cgImage scale:scale orientation:orientation];
}

#pragma mark - Initializers

- (id)initWithContentsOfFile:(NSString *)path
{
    self = [super init];
    if (self) {
        NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    }
    return self;
}

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    }
    return self;
}

- (id)initWithData:(NSData *)data scale:(CGFloat)scale
{
    self = [super init];
    if (self) {
        NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    }
    return self;
}

- (id)initWithCGImage:(CGImageRef)cgImage
{
    return [self initWithCGImage:cgImage scale:1 orientation:UIImageOrientationUp];
}

- (id)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [super init];
    if (self) {
        _imageRef = cgImage;
        _scale = scale;
        _imageOrientation = orientation;
    }
    return self;
}

- (CGImageRef)CGImage
{
    return _imageRef;
}

#pragma mark - Animated images

+ (UIImage *)animatedImageNamed:(NSString *)name duration:(NSTimeInterval)duration
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

+ (UIImage *)animatedResizableImageNamed:(NSString *)name capInsets:(UIEdgeInsets)capInsets duration:(NSTimeInterval)duration
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

+ (UIImage *)animatedResizableImageNamed:(NSString *)name capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode duration:(NSTimeInterval)duration
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

+ (UIImage *)animatedImageWithImages:(NSArray *)images duration:(NSTimeInterval)duration
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}


#pragma mark - Drawing
- (void)drawAtPoint:(CGPoint)point
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
}

- (void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
}

- (void)drawInRect:(CGRect)rect
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
}

- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
}

- (void)drawAsPatternInRect:(CGRect)rect
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
}



- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

- (UIImage *)imageWithAlignmentRectInsets:(UIEdgeInsets)alignmentInsets
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

- (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    return nil;
}

#pragma mark - NSCoding
- (void) encodeWithCoder: (NSCoder*)aCoder
{
    NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
}

- (id) initWithCoder: (NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        NSLog(@"Unimplemeted method: %s",__PRETTY_FUNCTION__);
    }
    return self;
}

@end

const CFStringRef kUTTypePNG = @"public.png";
const CFStringRef kUTTypeJPEG = @"public.jpeg";
const CFStringRef kUTTypeTIFF = @"public.tiff";

// return image as PNG. May return nil if image has no CGImageRef or invalid bitmap format
NSData *UIImagePNGRepresentation(UIImage *image)
{
    if (image.CGImage == NULL) {return nil;}
    
    CFMutableDataRef data = CFDataCreateMutable(NULL, 0);
    CGImageDestinationRef dest = CGImageDestinationCreateWithData(data, kUTTypePNG, 1, NULL);
    CGImageDestinationAddImage(dest, image.CGImage, NULL);
    CGImageDestinationFinalize(dest);
    return data;
}

 // return image as JPEG. May return nil if image has no CGImageRef or invalid bitmap format. compression is 0(most)..1(least)
NSData *UIImageJPEGRepresentation(UIImage *image, CGFloat compressionQuality)
{
    CFMutableDataRef data = CFDataCreateMutable(NULL, 0);
    CGImageDestinationRef dest = CGImageDestinationCreateWithData(data, kUTTypeJPEG, 1, NULL);
    NSDictionary *properties = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:compressionQuality] forKey:kCGImageDestinationLossyCompressionQuality];
    CGImageDestinationAddImage(dest, image.CGImage, properties);
    CGImageDestinationFinalize(dest);
    return data;
}


