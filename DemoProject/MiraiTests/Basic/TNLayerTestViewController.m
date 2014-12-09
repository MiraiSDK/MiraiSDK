//
//  TNLayerTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/29/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLayerTestViewController.h"
#import "TNShapeLayerTestViewController.h"
#import "TNLayerTransformTestViewController.h"
#import "TNLayerKeyPathTestViewController.h"
#import "TNLayerContentsGravityTestViewController.h"
#import "TNLayerOpacityTestViewController.h"

@interface TNLayerTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *subTests;
@end

@implementation TNLayerTestViewController
+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Layer Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.subTests = @[[TNShapeLayerTestViewController class],
                      [TNLayerTransformTestViewController class],
                      [TNLayerKeyPathTestViewController class],
                      [TNLayerContentsGravityTestViewController class],
                      [TNLayerOpacityTestViewController class],
                      ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100.0f;
    [self.view addSubview:tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subTests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Class testClass = self.subTests[indexPath.row];
    cell.textLabel.text = [testClass testName];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class testClass = self.subTests[indexPath.row];

    UIViewController *vc = [[testClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
