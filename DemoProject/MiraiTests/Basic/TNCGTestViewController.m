//
//  TNCGTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/10/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNCGTestViewController.h"
#import "TNCGImageResultViewController.h";

@interface TNCGTestViewController ()
@property (nonatomic, strong) NSArray *actions;
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
    
    __weak typeof(self) weakSelf = self;
    self.actions = @[
                     [TNTestCase testCaseWithName:@"Basic" action:^{
                         [weakSelf showImage:[weakSelf testBasic]];
                     }],
                     [TNTestCase testCaseWithName:@"Tiled" action:^{
                         [weakSelf showImage:[weakSelf testTiled]];
                     }],
                     ];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 100;
    [self.view addSubview:table];
}

- (void)showImage:(UIImage *)image
{
    TNCGImageResultViewController *result = [[TNCGImageResultViewController alloc] init];
    result.image = image;
    [self.navigationController pushViewController:result animated:YES];
}

- (UIImage *)testBasic
{
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIColor *c = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [c setFill];
    
    UIColor *w = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [w setFill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)testTiled
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 50), YES, 0);
    [[UIColor redColor] setFill];
    UIRectFill(CGRectMake(0, 0, 25, 25));
    
    [[UIColor greenColor] setFill];
    UIRectFill(CGRectMake(25, 0, 25, 25));
    
    [[UIColor blueColor] setFill];
    UIRectFill(CGRectMake(0, 25, 25, 25));

    [[UIColor blackColor] setFill];
    UIRectFill(CGRectMake(25, 25, 25, 25));

    UIImage *tiledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 400), YES, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, CGRectMake(20, 20, 260, 360));
    CGContextDrawTiledImage(ctx, CGRectMake(0, 0, 100, 100), tiledImage.CGImage);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TNTestCase *tc = self.actions[indexPath.row];
    cell.textLabel.text = tc.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTestCase *tc = self.actions[indexPath.row];
    tc.action();
}

@end
