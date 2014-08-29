//
//  TNImageTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 4/8/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNImageTestViewController.h"

@interface TNImageTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;
@end

@implementation TNImageTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Image Test";
}

- (NSArray *)images
{
    if (!_images) {
        _images = @[
                    @[@"testImage",@"png"],
                    @[@"testImage",@"jpg"],
                    @[@"testImage",@"tiff"],
                    @[@"rgbatest",@"png"],
                    @[@"38162749",@"jpg"],
                    //@[@"Gray 8Bit",@"png"],
                    @[@"alice 8Bit Color Indexed",@"png"],
                    @[@"alice 8Bit Indexed",@"png"],
                    @[@"alice 8Bit Grayscale",@"png"],
                    @[@"alice 8Bit RGB",@"png"],
                    @[@"alice 8Bit RGBA",@"png"],
                    //@[@"Gray 16Bit",@"png"],
                    @[@"alice 16Bit Grayscale",@"png"],
                    @[@"alice 16Bit RGB",@"png"],
                    @[@"alice 16Bit RGBA",@"png"],
                    ];
    }
    return _images;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(didPressedClearItem:)];
    self.navigationItem.rightBarButtonItems = @[clearItem];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView = imageView;
}

- (void)didPressedClearItem:(id)sender
{
    self.imageView.image = nil;
    [self.imageView removeFromSuperview];
}

- (void)testImageNamed:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.imageView.image = image;
    [self.view addSubview:self.imageView];
}

#pragma mark - Legcy
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *info = self.images[indexPath.row];
    cell.textLabel.text = [info componentsJoinedByString:@"."];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *info = self.images[indexPath.row];

    [self testImageNamed:info[0] type:info[1]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
