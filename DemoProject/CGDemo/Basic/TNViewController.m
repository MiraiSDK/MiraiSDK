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

@interface TNViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *tests;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tests = [[TNTestViewController tests] sortedArrayUsingComparator:^NSComparisonResult(Class c1, Class c2) {
            return [[c1 testName] compare:[c2 testName]];
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Main";
    self.navigationItem.title = @"Tests";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
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
}

@end
