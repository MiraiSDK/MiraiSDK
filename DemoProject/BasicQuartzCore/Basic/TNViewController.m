//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

#import "TNTestViewController.h"

#import "TNButtonTestViewController.h"
#import "TNImageTestViewController.h"
#import "TNScrollTestViewController.h"
#import "TNLabelTestViewController.h"
#import "TNAlertViewTestViewController.h"
#import "TNAnimationTestViewController.h"
#import "TNTableViewTestController.h"
#import "TNViewTestViewController.h"

#import "TNShapeLayerTestViewController.h"
#import "TNCGTestViewController.h"

@interface TNViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UILabel *tapCountLabel;

@property (nonatomic, strong) NSArray *tests;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Main";
    self.navigationItem.title = @"ItemMain";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tests = @[[TNCGTestViewController class],
                   [TNViewTestViewController class],
                   [TNLabelTestViewController class],
                   [TNButtonTestViewController class],
                   [TNImageTestViewController class],
                   [TNScrollTestViewController class],
                   [TNAlertViewTestViewController class],
                   [TNAnimationTestViewController class],
                   [TNTableViewTestController class],
                   [TNShapeLayerTestViewController class],
                   [TNScrollTestViewController class],
                   [TNScrollTestViewController class],
                   [TNScrollTestViewController class]];
    
    
//    UILabel *tapCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 10, 300, 150)];
//    tapCountLabel.text = @"tap cout: 0";
//    [s addSubview:tapCountLabel];
//    self.tapCountLabel = tapCountLabel;

//    NSInteger level = self.navigationController.viewControllers.count;
//    CGFloat c = (level%8)/7.0;
//    NSLog(@"c: %.2f",c);
//    self.view.backgroundColor = [UIColor colorWithHue:c saturation:c brightness:c alpha:1];
    
    
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
//
    
 
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

- (void)addSubViewRule
{
//    CGFloat height = 20;
//    NSArray *colors = @[[UIColor colorWithRed:1 green:0 blue:0 alpha:1],
//                        [UIColor colorWithRed:0 green:1 blue:0 alpha:1],
//                        [UIColor colorWithRed:0 green:0 blue:1 alpha:1],
//                        [UIColor colorWithRed:1 green:1 blue:0 alpha:1],
//                        [UIColor colorWithRed:0 green:1 blue:1 alpha:1],
//                        [UIColor colorWithRed:1 green:0 blue:1 alpha:1],];
//    for (int i = 0; i<6; i++) {
//        UIView *rule = [[UIView alloc] initWithFrame:CGRectMake(0, i*height, 320, height)];
//        rule.backgroundColor = colors[i];
//        [self.view addSubview:rule];
//    }

}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
}

- (void)button1Pressed:(id)sender
{
    static NSInteger count = 0;
    count++;
    self.tapCountLabel.text = [NSString stringWithFormat:@"tap count:%d",count];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Class class = self.tests[indexPath.row];
    cell.textLabel.text = [class testName];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static CGFloat height = 0.0f;
    if (height == 0) {
        height = 112.0f/[UIScreen mainScreen].scale;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s Row:%d",__PRETTY_FUNCTION__,indexPath.row);
    Class class = self.tests[indexPath.row];
    UIViewController *vc = [[class alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];

//    [tableView setContentOffset:CGPointZero animated:YES];
//    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
