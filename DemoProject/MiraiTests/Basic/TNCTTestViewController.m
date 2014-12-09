//
//  TNCTTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/19/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCTTestViewController.h"
#import "TNCTView.h"
#import <CoreText/CoreText.h>

@interface TNCTTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TNCTView *ctView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *actions;

@end

@implementation TNCTTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Core Text Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAttributedString *att = [self attributedStringWithFontSize:27];

    
    CGRect rect = CGRectInset(self.view.bounds, 0, 120);
//    TNCTView *v = [[TNCTView alloc] initWithFrame:rect];
//    v.attributedString = att;
//    [self.view addSubview:v];
//    v.hidden = YES;
//    self.ctView = v;
    
    UIView *bg = [[UIView alloc] initWithFrame:rect];
    bg.layer.borderWidth = 1;
    bg.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:bg];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
//    imageView.image = [self imageForAttributedString:att size:rect.size];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handle_tap:)];
//    [self.view addGestureRecognizer:tap];
    
    __weak typeof(self) weakSelf = self;
    self.actions =
  @[
    [TNTestCase testCaseWithName:@"CTFrameDraw" action:^{
        UIImage *image = [weakSelf imageCTFrameDrawForAttributedString:att size:rect.size];
        imageView.image = image;

    }],
    [TNTestCase testCaseWithName:@"drawInRect" action:^{
        UIImage *image = [weakSelf imageForAttributedString:att size:rect.size];
        imageView.image = image;
    }],
    ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), rect.size.width, self.view.bounds.size.height - CGRectGetMaxY(imageView.frame))];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(didPressedClearItem:)];
    self.navigationItem.rightBarButtonItems = @[clearItem];
}

- (void)didPressedClearItem:(id)sender
{
    self.imageView.image = nil;
}


- (void)handle_tap:(UITapGestureRecognizer *)tap
{
    if (self.ctView.isHidden) {
        [self.view addSubview:self.ctView];
        [self.imageView removeFromSuperview];
        self.ctView.hidden = NO;
        self.imageView.hidden = YES;
    } else {
        [self.view addSubview:self.imageView];
        [self.ctView removeFromSuperview];
        self.ctView.hidden = YES;
        self.imageView.hidden = NO;
    }
}

- (UIImage *)imageCTFrameDrawForAttributedString:(NSAttributedString *)attr size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CTFramesetterRef fr = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attr);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);

    
    CGRect rect = {CGPointZero, size};
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    CTFrameRef f = CTFramesetterCreateFrame(fr, CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(f, ctx);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageForAttributedString:(NSAttributedString *)attr size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [attr drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TNTestCase *tc = self.actions[indexPath.row];
    cell.textLabel.text = tc.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTestCase *tc = self.actions[indexPath.row];
    if (tc.action) {
        tc.action();
    }
}


#pragma mark - Text
#if __ANDROID__
#define TN_ARC_BRIDGE
#else
#define TN_ARC_BRIDGE (__bridge id)
#endif
- (NSAttributedString *)attributedStringWithFontSize:(CGFloat)size
{
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)([self fontAttributes]));
    CTTextAlignment alignment = kCTTextAlignmentCenter;
    CTParagraphStyleSetting settings[] = {
        kCTParagraphStyleSpecifierAlignment,sizeof(CTTextAlignment),&alignment
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    CTFontRef font = CTFontCreateWithFontDescriptor(desc, size, NULL);
    
    UIColor *color = [UIColor blueColor];
    
    UIColor *textColor = [UIColor colorWithRed:125.0f/255.0f green:159.0f/255.0f blue:132.0f/255.0f alpha:1];
    
    NSMutableAttributedString *att= [[NSMutableAttributedString alloc] initWithString:@"　@不吃葱花教:很小的时候，没有适合自己的枕头，一直枕着母亲的手臂睡觉，一年又一年，那该有多难受...\n" attributes:@{
                                                                                                                                                            (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                            (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                            (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName:TN_ARC_BRIDGE textColor.CGColor,
                                                                                 (NSString *)                                                                           kCTParagraphStyleAttributeName: TN_ARC_BRIDGE style
                                                                                                                                                            }];
    
    
    NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"@张苏沛:初三的时候，晚上睡很晚，曾经一度晚上两三点才睡觉，当时没有电热毯，是我妈每天晚上先睡我床上为我暖被窝，等我写完作业，她才回她的房间睡。早上我一般是六点起床，我妈五点半就起来了，下楼给我买饭然后端上来给我吃，或者早起在家里自己给我做，从来没有塞给我几块钱让我下楼自己买。\n" attributes:@{
                                                                                                                                                                                                                                        (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                                                                                                        (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                                                                                                        (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName:TN_ARC_BRIDGE [UIColor greenColor].CGColor
                                                                                                                                                                                                                                        }];
    NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:@"@小亲亲:记得上大一的时候，有一次随手在QQ个签上写了一句“好想回家”，这件事我很快就忘记了。很久之后，跟妈妈说话的时候，她跟我说，看见我写的那句" attributes:@{
                                                                                                                                                                    (NSString *)kCTFontAttributeName:TN_ARC_BRIDGE font,
                                                                                                                                                                    (NSString *)kCTKernAttributeName:@(-0.02),
                                                                                                                                                                    (NSString *)                                                                                                                                                                                                                                                                                                           kCTForegroundColorAttributeName: TN_ARC_BRIDGE [UIColor blueColor].CGColor
                                                                                                                                                                    }];
    [att appendAttributedString:att1];
    [att appendAttributedString:att2];
    
    return att;
    
}

- (NSDictionary *)fontAttributes
{
    return @{
             (NSString *)kCTFontFamilyNameAttribute : @"Helvetica",
             };
}

@end
