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

#import "TNDemoViewController.h"

#import "TNLabelDemoViewController.h"
#import "TNButtonDemoViewController.h"
#import "TNImageDemoViewController.h"
#import "TNAlertViewDemoViewController.h"
#import "TNWebViewDemoViewController.h"
#import "TNTableViewDemoViewController.h"
#import "TNScrollViewDemoViewController.h"
#import "TNPickerViewDemoViewController.h"
#import "TNSwitchDemoViewController.h"
#import "TNStepperDemoViewController.h"
#import "TNSegmentedControlDemoViewController.h"
#import "TNTextFieldDemoViewController.h"
#import "TNTextViewDemoViewController.h"
#import "TNSliderDemoViewController.h"
#import "TNDatePickerDemoViewController.h"

#import "TNTabBarControllerDemoViewController.h"
#import "TNNavigationDemoViewController.h"
#import "TNTableViewControllerDemoViewController.h"
#import "TNSearchControllerDemoViewController.h"


@interface TNViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *demos;
@property (nonatomic, strong) NSArray *demoNames;
@property (nonatomic, strong) NSArray *sectionNames;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Mirai Demos";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demos = @{
//                   @"UIView" : [TNLabelDemoViewController class],
                   @"UILabel" : [TNLabelDemoViewController class],
                   @"UIButton" : [TNButtonDemoViewController class],
                   @"UImageView" : [TNImageDemoViewController class],
                   @"UIScrollView" : [TNScrollViewDemoViewController class],
                   @"UITableView" : [TNTableViewDemoViewController class],
                   @"UIWebView" : [TNWebViewDemoViewController class],
                   @"UINavigationController" : [TNNavigationDemoViewController class],
                   @"UITableViewController" : [TNTableViewControllerDemoViewController class],
                   @"UITabBarController" : [TNTabBarControllerDemoViewController class],

                   @"UIAlertView" : [TNAlertViewDemoViewController class],
                   @"UIPickerView" : [TNPickerViewDemoViewController class],
                   @"UISwitch" : [TNSwitchDemoViewController class],
                   @"UIStepper" : [TNStepperDemoViewController class],
                   @"UISearchController" : [TNSearchControllerDemoViewController class],
                   @"UISegmentedControl" : [TNSegmentedControlDemoViewController class],
                   @"UITextField" : [TNTextFieldDemoViewController class],
                   @"UITextView" : [TNTextViewDemoViewController class],
                   @"UISlider" : [TNSliderDemoViewController class],
                   @"UIDatePicker" : [TNDatePickerDemoViewController class],

                   };
    self.sectionNames = @[@"Views",@"Controllers",@"Other"];
    self.demoNames = @[
                       @[ // Views
                           //@"UIView",
                           @"UILabel",
                           @"UIButton",
                           @"UImageView",
                           @"UIScrollView",
                           @"UITableView",
                           @"UIWebView",
                           @"UIAlertView",
                           @"UIPickerView",
                           @"UIDatePicker",
                           @"UISwitch",
                           @"UIStepper",
                           @"UISearchBar",
                           @"UISearchController",
                           @"UISegmentedControl",
                           @"UISlider",
                           @"UITextField",
                           @"UITextView",
                           ],
                       @[ //Controllers
                           @"UINavigationController", //Navigation bar, tool bar
                           @"UITableViewController",
                           @"UITabBarController",
                           ],
                       @[], //Other
                       ];
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
#if __ANDROID__
    tableView.rowHeight = 100;
#endif
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
    return self.demoNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.demoNames[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *name = self.demoNames[indexPath.section][indexPath.row];
    cell.textLabel.text = name;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.demoNames[indexPath.section][indexPath.row];
    Class class = self.demos[name];
    if (class) {
        UIViewController *vc = [[class alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionNames[section];
}
@end
