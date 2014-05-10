//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <CoreText/CoreText.h>
#import "TNCustomView.h"
#import <QuartzCore/QuartzCore.h>

#import "TNButtonTestViewController.h"
#import "TNImageTestViewController.h"
#import "TNScrollTestViewController.h"
//#import "TNTestViewController.h"

@interface TNViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UILabel *tapCountLabel;

@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSArray *tests;
@end

@implementation TNViewController

- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    
    self.tests = @[[TNButtonTestViewController class],[TNImageTestViewController class],[TNScrollTestViewController class]];
    
    
//    [self addImageWithName:@"testImage" type:@"png" atRect:CGRectMake(0, 0, 720, 1024)];

    // button press test
//    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [b1 setTitle:@"Button" forState:UIControlStateNormal];
//    b1.frame = CGRectMake(50, 10, 300, 150);
//    [b1 addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
//    [s addSubview:b1];
    
//    UILabel *tapCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 10, 300, 150)];
//    tapCountLabel.text = @"tap cout: 0";
//    [s addSubview:tapCountLabel];
//    self.tapCountLabel = tapCountLabel;

//    NSInteger level = self.navigationController.viewControllers.count;
//    CGFloat c = (level%8)/7.0;
//    NSLog(@"c: %.2f",c);
//    self.view.backgroundColor = [UIColor colorWithHue:c saturation:c brightness:c alpha:1];
    

//    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"button_search_normal" ofType:@"png"];
//    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"button_search_pressed" ofType:@"png"];
//    UIImage *image1 = [UIImage imageWithContentsOfFile:path1];
//    UIImage *image2 = [UIImage imageWithContentsOfFile:path2];
//    self.image1 = image1;
//    self.image2 = image2;
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button setTitle:@"Push" forState:UIControlStateNormal];
////    [button setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
//    [button setBackgroundImage:image1 forState:UIControlStateNormal];
//    [button setBackgroundImage:image2 forState:UIControlStateHighlighted];
//    [button addTarget:self action:@selector(buttonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [button setFrame:CGRectMake(50, 200, 300, 150)];
//    self.pushButton = button;
//    
//    [s addSubview:button];
    
//    self.array = [NSMutableArray array];
    
//    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    popButton.frame = CGRectMake(50, 400, 300, 150);
//    [popButton setTitle:@"Pop" forState:UIControlStateNormal];
//    [popButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [popButton addTarget:self action:@selector(popButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [popButton setBackgroundColor:[UIColor greenColor]];
//    [popButton addTarget:self action:@selector(buttonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [s addSubview:popButton];
//    self.popButton = popButton;
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    self.imageView = imageView;
//    imageView.image = image1;
//    [self.view addSubview:imageView];
//    UIButton *round = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    round.frame = CGRectMake(50, 500, 300, 150);
//    [round setTitle:@"Rounded" forState:UIControlStateNormal];
//    [self.view addSubview:round];
    
    
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//    label.text = [NSString stringWithFormat:@"level:%d",self.navigationController.viewControllers.count];
//    label.font = [UIFont systemFontOfSize:25];
//    [self.view addSubview:label];

    
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

    TNCustomView *custom = [[TNCustomView alloc] initWithFrame:CGRectMake(0, 80, 300, 300)];
    [self.view addSubview:custom];
    
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
    
 
//    CGFloat buttonY = 1280-150-28;
//    UIButton *bottomLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [bottomLeft setTitle:@"ScrollTest" forState:UIControlStateNormal];
//    bottomLeft.frame = CGRectMake(50, buttonY, 200, 150);
//    [bottomLeft addTarget:self action:@selector(scrollTest1:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bottomLeft];
//    
//    UIButton *bottomRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [bottomRight setTitle:@"ScrollTest2" forState:UIControlStateNormal];
//    bottomRight.frame = CGRectMake(300, buttonY, 200, 150);
//    [bottomRight addTarget:self action:@selector(scrollTest2:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:bottomRight];
    
    
}

- (void)button1Pressed:(id)sender
{
    static NSInteger count = 0;
    count++;
    self.tapCountLabel.text = [NSString stringWithFormat:@"tap count:%d",count];
}

- (void)addImageWithName:(NSString *)name type:(NSString *)type atRect:(CGRect)rect
{
//    CGImageRef imageRef = [self createImageNamed:name type:type];
//    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = rect;
//
//    [self.scrollView addSubview:imageView];
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

- (void)buttonDidPressed:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
//    UIViewController *vc = [[UIViewController alloc] init];
//    TNViewController *vc = [[TNViewController alloc] init];
//    NSLog(@"navigationController:%@",self.navigationController);
//    [self.navigationController pushViewController:vc animated:YES];
//    [UIView beginAnimations:@"ddd" context:nil];
//    [UIView setAnimationDuration:5];
//    self.red.frame = CGRectMake(50, 300, 300, 150);
//    [UIView commitAnimations];
//    UIButton *button = self.popButton;
  
//    if (self.imageView.image == self.image1) {
//        self.imageView.image = self.image2;
//        NSLog(@"set image 2");
//    } else {
//        self.imageView.image = self.image1;
//        NSLog(@"set image 1");
//    }
//    NSLog(@"image:%@", button.imageView.image);
//    if (CATransform3DIsIdentity(button.layer.transform)) {
//        [button.layer setTransform:CATransform3DMakeTranslation(250, 0, 0)];
//    } else {
//        [button.layer setTransform:CATransform3DIdentity];
//    }
    
//    [self.scrollView scrollRectToVisible:CGRectMake(0, 400, 720, 500) animated:NO];
}

- (void)popButtonDidPressed:(id)sender
{
//    NSLog(@"%s",_pre);
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)showAlert:(id)sender
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Hello World" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//}

#pragma mark - scrollTest
- (void)scrollTest1:(id)sender
{
//    [self.scrollView scrollRectToVisible:CGRectMake(0, 1280, 720, 1280) animated:NO];
//    NSLog(@"%@",self.scrollView);
//    NSLog(@"scroll bounds:%@",NSStringFromCGRect(self.scrollView.bounds));
}

- (void)scrollTest2:(id)sender
{
//    [self.scrollView scrollRectToVisible:self.view.bounds animated:NO];
//    NSLog(@"%@",self.scrollView);
}

#pragma mark -
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


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;//self.tests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    Class class = self.tests[indexPath.row];
//    cell.textLabel.text = [class testName];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d",indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static CGFloat height = 0.0f;
    if (height == 0) {
        height = 100.0f/[UIScreen mainScreen].scale;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s Row:%d",__PRETTY_FUNCTION__,indexPath.row);
//    Class class = self.tests[indexPath.row];
//    UIViewController *vc = [[class alloc] init];
    TNButtonTestViewController *vc = [[TNButtonTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
