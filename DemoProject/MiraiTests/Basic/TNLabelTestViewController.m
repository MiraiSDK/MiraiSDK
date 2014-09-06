//
//  TNLabelTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLabelTestViewController.h"

@implementation TNLabelTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UILabel";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    label.text = [NSString stringWithFormat:@"Label With Frame:%@ default 1 line",NSStringFromCGRect(label.frame)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, 320, 200)];
    label1.text = [NSString stringWithFormat:@"Label With Frame:%@, numberOfLines 0",NSStringFromCGRect(label1.frame)];
    label1.textColor = [UIColor redColor];
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, 320, 200)];
    label2.text = [NSString stringWithFormat:@"Label With Frame:%@,\n numberOfLines 0",NSStringFromCGRect(label2.frame)];
    label2.textColor = [UIColor redColor];
    label2.textAlignment = NSTextAlignmentRight;
    label2.shadowColor = [UIColor greenColor];
    label.shadowOffset = CGSizeMake(5, 5);
    [self.view addSubview:label2];
    
    //highlightedTextColor?

}
@end
