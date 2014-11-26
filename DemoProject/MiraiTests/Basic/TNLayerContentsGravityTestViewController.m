//
//  TNLayerContentsGravityTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 11/24/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNLayerContentsGravityTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TNLayerContentsGravityTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation TNLayerContentsGravityTestViewController
+ (NSString *)testName
{
    return @"Layer contentsGravity";
}

- (void)didPressedClearItem:(UIBarButtonItem *)item
{
    self.layer.contents = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItems =
    @[
      [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(didPressedClearItem:)],
      
      ];
    __weak typeof(self) weakSelf = self;
    self.actions =
  @[
    @[
        [TNTestCase testCaseWithName:@"Load small image" action:^{
            [weakSelf setImageNamed:@"ContentsGravity_Small.jpg"];
        }],
        [TNTestCase testCaseWithName:@"Load matched image" action:^{
            [weakSelf setImageNamed:@"ContentsGravity_300x400.jpg"];
        }],
        [TNTestCase testCaseWithName:@"Load large image" action:^{
            [weakSelf setImageNamed:@"ContentsGravity_Large.jpg"];
        }],
        [TNTestCase testCaseWithName:@"change masksToBounds" action:^{
            CALayer *l = [weakSelf layer];
            [l setMasksToBounds:!l.masksToBounds];
        }],
        ],
    @[
        [TNTestCase testCaseWithName:kCAGravityCenter action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityTop action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityBottom action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityLeft action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityRight action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityTopLeft action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityTopRight action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityBottomLeft action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityBottomRight action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityResize action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityResizeAspect action:^{
            
        }],
        [TNTestCase testCaseWithName:kCAGravityResizeAspectFill action:^{
            
        }],
        ],
    
    ];
    
    
#if __ANDROID__
    CGFloat y = 500;
#else
    CGFloat y = 200;
#endif
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    CALayer *layer = [CALayer layer];
#if __ANDROID__
    layer.frame = CGRectMake(100, 100, 300, 400);
    tableView.rowHeight = 100;
#else
    layer.frame = CGRectMake(10, 55, 150, 200);
#endif
    layer.borderWidth = 6;
    layer.borderColor = [UIColor redColor].CGColor;
    
    self.layer = layer;
    
    CALayer *l = [CALayer layer];
    l.frame = layer.frame;
    l.borderWidth = 10;
    l.borderColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:l];
    
    [self.view.layer addSublayer:layer];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    CGFloat y = 500;
//
//    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - y);
}

- (void)setImageNamed:(NSString *)name
{
    self.image = [UIImage imageNamed:name];
#if __ANDROID__
    self.layer.contents = (self.image.CGImage);
#else
    self.layer.contents = (__bridge id) (self.image.CGImage);
#endif
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.actions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.actions[section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TNTestCase *tc = self.actions[indexPath.section][indexPath.row];
    cell.textLabel.text = tc.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTestCase *tc = self.actions[indexPath.section][indexPath.row];
    if (indexPath.section == 1) {
        self.layer.contentsGravity = tc.name;
        NSLog(@"set contentsGravity:%@",tc.name);
    } else {
        tc.action();
    }
}

@end
