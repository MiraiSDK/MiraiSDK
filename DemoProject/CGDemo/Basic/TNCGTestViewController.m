//
//  TNCGTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/10/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCGTestViewController.h"

@interface TNCGTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *testcases;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TNCGTestViewController

+ (NSString *)testName
{
    return @"Core Graphics Test";
}

+ (void)load
{
    [self regisiterTestClass:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 110;
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clearImage)];
    self.navigationItem.rightBarButtonItems = @[clear];
    
    
    self.testcases = @[
                   [TNTestCase testCaseWithName:@"memory image loading" action:^{
                       CGRect rect = CGRectMake(0, 0, 512, 512);

                       UIGraphicsBeginImageContext(rect.size);
                       UIColor *c = [[UIColor grayColor] colorWithAlphaComponent:0.5];
                       [c setFill];
                       UIRectFill(rect);
                       
                       UIColor *w = [[UIColor redColor] colorWithAlphaComponent:0.5];
                       [w setFill];
                       CGRect r = CGRectInset(rect, -20, -20);
                       UIRectFill(r);
                       
                       UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                       UIGraphicsEndImageContext();
                       self.imageView.image = image;
                   }],
                   [TNTestCase testCaseWithName:@"empty" action:^{
                       
                   }],
                   [TNTestCase testCaseWithName:@"empty" action:^{
                       
                   }],
                   [TNTestCase testCaseWithName:@"empty" action:^{
                       
                   }],
                   ];
}

- (void)clearImage
{
    self.imageView.image = nil;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testcases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TNTestCase *tc = self.testcases[indexPath.row];
    cell.textLabel.text = tc.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTestCase *tc = self.testcases[indexPath.row];
    NSDate *begin = [NSDate date];
    
    tc.action();
    
    NSTimeInterval usage = -[begin timeIntervalSinceNow];
    NSLog(@"action:%@ usage:%f seconds",tc.name,usage);
}

@end
