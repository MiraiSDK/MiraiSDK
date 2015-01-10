//
//  TNTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 4/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNTestViewController.h"

@interface TNTestViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *subTests;
@end

@implementation TNTestViewController

static NSMutableArray *testClasses = nil;

+ (void)regisiterTestClass:(Class)cls
{
    if (nil == testClasses) {
        testClasses = [NSMutableArray array];
    }
    
    if ([cls isSubclassOfClass: [TNTestViewController class]])
    {
        [testClasses addObject: cls];
    } else {
        [NSException raise: NSInvalidArgumentException format: @"+[TNTestViewController regisiterTestClass:] called with invalid class"];
    }
}

+ (NSArray *)tests
{
    return testClasses;
}

+ (NSArray *)subTests
{
    return nil;
}

+ (NSString *)testName
{
    return @"Untitled Test";
}

- (NSString *)testDescription
{
    return nil;
}

- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [[self class] testName];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *desc = [self testDescription];
    if (desc) {
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        descLabel.text = desc;
        [self.view addSubview:descLabel];
    }
    
    self.subTests = [[self class] subTests];
    if (self.subTests) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 100.0f;
        [self.view insertSubview:tableView atIndex:0];
    }
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
