//
//  TNRunloopTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 8/7/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNRunloopTestViewController.h"

@interface TNRunloopTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *tests;
@end

@implementation TNRunloopTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Runloop Test";
}

- (void)printLog
{
    NSLog(@"thread:%@",[NSThread currentThread]);
    NSLog(@"Fire!!");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tests = @[
                   [[TNTestCase alloc]initWithName:@"performSelector:withObject:" action:^{
                       NSLog(@"will call performSelector:");
                       [self performSelector:@selector(printLog) withObject:nil];
                       NSLog(@"done call performSelector:");
                   }],

                   [[TNTestCase alloc]initWithName:@"performSelector delay 0" action:^{
                       NSLog(@"will call performSelector:");
                       [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
                       NSLog(@"done call performSelector:");
                   }],
                   [[TNTestCase alloc]initWithName:@"performSelector delay 5" action:^{
                       NSLog(@"will call performSelector:");
                       [self performSelector:@selector(printLog) withObject:nil afterDelay:5];
                       NSLog(@"will call performSelector:");
                   }],
                   [[TNTestCase alloc]initWithName:@"performSelector delay 0 in default runloop" action:^{
                       NSLog(@"will call performSelector:");
                       [self performSelector:@selector(printLog) withObject:nil afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
                       NSLog(@"will call performSelector:");
                   }],
                   [[TNTestCase alloc]initWithName:@"Run in MainQueue" action:^{
                       [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                           [self printLog];
                       }];
                   }],
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
    return self.tests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TNTestCase *test = self.tests[indexPath.row];
    cell.textLabel.text = [test name];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTestCase *test = self.tests[indexPath.row];
    test.action();
}

@end
