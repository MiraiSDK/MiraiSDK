//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <QuartzCore/QuartzCore.h>

#import <NextBookKit/NextBookKit.h>
#import <dispatch/dispatch.h>

#import "TNSecondViewController.h"

@interface TNViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NBBook *book;

@property (nonatomic, strong) NSArray *bookNames;
@end

@implementation TNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NBBookLib authWithDeveloperID:@"" key:@""];

    self.bookNames = @[@"Untitled",
                       @"FullWidgetSample",
                       @"Simple",
                       @"Chinese",
                       @"zuguoduoliaokuo",
                       @"yaodaipeixun",
                       @"manziwenzai"];

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSString *)pathForBookName:(NSString *)name
{
    return [[NSBundle mainBundle] pathForResource:name ofType:@"ibooks"];
}

- (void)loadBookAtPath:(NSString *)path
{
    NSLog(@"book path:%@",path);

    if (path) {
        NSLog(@"will init book");
        NBBook *book = [[NBBook alloc] initWithContentsOfFile:path];
        NSLog(@"book:%@",book);
        
        if ([book isReadyForOpen]) {
            NSLog(@"book:%@",book);
            NSLog(@"title:%@ chapters:%@",book.bookTitle,book.chapters);
            NBBookViewController *vc = [[NBBookViewController alloc] initWithBook:book];
            [self presentViewController:vc animated:YES completion:nil];
            
        } else {
            
            [book prepareForOpenOnProcessing:^(NSInteger idx, NSInteger total) {
                NSLog(@"Book loading %d/%d",idx,total);
            } onCompletion:^(NBBook *book) {
                NSLog(@"prepare completion.");
                NSLog(@"book:%@",book);
                NSLog(@"title:%@ chapters:%@",book.bookTitle,book.chapters);
                NBBookViewController *vc = [[NBBookViewController alloc] initWithBook:book];
                
                //            NBBookNavigationController *nav = [[NBBookNavigationController alloc] initWithContentViewController:vc];
                [self presentViewController:vc animated:YES completion:nil];
            }];
        }
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.bookNames[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.bookNames[indexPath.row];
    NSString *path = [self pathForBookName:name];
    
    [self loadBookAtPath:path];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
