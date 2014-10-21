//
//  TNPickerViewDemoViewController.m
//  MiraiDemos
//
//  Created by Chen Yonghui on 10/20/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNPickerViewDemoViewController.h"

@interface TNPickerViewDemoViewController ()  <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, strong) NSArray *components;
@property (nonatomic, strong) UILabel *resultLabel;
@end

@implementation TNPickerViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.components = @[
                        @[@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39"],
                        @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",],
                        ];
    
    CGFloat pickerHeight = 400;
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-pickerHeight, self.view.bounds.size.width, pickerHeight)];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    self.picker = picker;
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 33)];
    [self.view addSubview:resultLabel];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel = resultLabel;
    
    [self updateResult];
}

- (void)updateResult
{
    
    NSInteger idx0 = [self.picker selectedRowInComponent:0];
    NSInteger idx1 = [self.picker selectedRowInComponent:1];
    
    self.resultLabel.text = [NSString stringWithFormat:@"You select: %@%@",self.components[0][idx0],self.components[1][idx1]];
}
#pragma mark - DataSource
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return self.components.count;
//}
//
//// returns the # of rows in each component..
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    NSArray *c = self.components[component];
//    return c.count;
//}

#pragma mark - Delegate
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSArray *c = self.components[component];
//    return c[row];
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    [self updateResult];
//    
//}
@end
