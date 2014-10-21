//
//  TNLabelDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLabelDemoViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface TNLabelDemoViewController ()

@end

@implementation TNLabelDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UILabel";
    
    CGFloat yOffset = 120;
    CGFloat gap = 5;
    CGFloat x = 10;
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(x, yOffset, 100, 100)];
    lable1.text = @"lable1";
    [lable1 sizeToFit];
    [self.view addSubview:lable1];
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lable1.frame) + gap, yOffset, 100, 100)];
    lable2.text = @"lable2";
    lable2.layer.borderWidth = 1;
    [lable2 sizeToFit];
    [self.view addSubview:lable2];
    
    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lable2.frame) + gap, yOffset, 100, 100)];
    lable3.text = @"lable3";
    lable3.backgroundColor = [UIColor colorWithHue:0.75 saturation:0.33 brightness:1.0 alpha:1];
    lable3.textColor = [UIColor colorWithHue:0.33 saturation:0.75 brightness:1 alpha:1];
    [lable3 sizeToFit];
    [self.view addSubview:lable3];
    
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lable3.frame) + gap, yOffset, 100, 100)];
    lable4.text = @"lable4";
    lable4.font = [UIFont systemFontOfSize:20];
    lable4.backgroundColor = [UIColor colorWithHue:1 saturation:0.33 brightness:1.0 alpha:1];
    lable4.textColor = [UIColor colorWithHue:1 saturation:0.75 brightness:1 alpha:1];
    [lable4 sizeToFit];
    [self.view addSubview:lable4];

    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(x, gap + CGRectGetMaxY(lable4.frame), 100, 100)];
    lable5.text = @"lable5";
    lable5.font = [UIFont systemFontOfSize:40];
    lable5.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable5.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [lable5 sizeToFit];
    [self.view addSubview:lable5];

    UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(x, gap + CGRectGetMaxY(lable5.frame), 180, 33)];
    lable6.text = @"Left";
    lable6.textAlignment = NSTextAlignmentLeft;
    lable6.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable6.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [self.view addSubview:lable6];
    
    UILabel *lable7 = [[UILabel alloc] initWithFrame:CGRectMake(x, gap + CGRectGetMaxY(lable6.frame), 180, 33)];
    lable7.text = @"Center";
    lable7.textAlignment = NSTextAlignmentCenter;
    lable7.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable7.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [self.view addSubview:lable7];

    UILabel *lable8 = [[UILabel alloc] initWithFrame:CGRectMake(x, gap + CGRectGetMaxY(lable7.frame), 180, 33)];
    lable8.text = @"Right";
    lable8.textAlignment = NSTextAlignmentRight;
    lable8.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable8.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [self.view addSubview:lable8];
    
    UILabel *lable9 = [[UILabel alloc] initWithFrame:CGRectMake(x, gap + CGRectGetMaxY(lable8.frame), 180, 44)];
    lable9.text = @"Multi Line Lable\nline2\nline3\nline4";
    lable9.numberOfLines = 0;
    lable9.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable9.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [lable9 sizeToFit];
    [self.view addSubview:lable9];
    
    UILabel *lable10 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lable9.frame) + gap, gap + CGRectGetMaxY(lable8.frame), 180, 44)];
    lable10.text = @"Multi Line Lable\nline2\nline3\nline4";
    lable10.numberOfLines = 0;
    lable10.textAlignment = NSTextAlignmentRight;
    lable10.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable10.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [lable10 sizeToFit];
    [self.view addSubview:lable10];

    UILabel *lable11 = [[UILabel alloc] initWithFrame:CGRectMake(x, gap + CGRectGetMaxY(lable9.frame), 180, 44)];
    lable11.text = @"Multi Line Lable\nline2\nline3\nline4";
    lable11.numberOfLines = 0;
    lable11.textAlignment = NSTextAlignmentCenter;
    lable11.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.33 brightness:1.0 alpha:1];
    lable11.textColor = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    [lable11 sizeToFit];
    [self.view addSubview:lable11];

    //TODO:shadow
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
