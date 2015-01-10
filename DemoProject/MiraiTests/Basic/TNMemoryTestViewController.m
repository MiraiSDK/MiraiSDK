//
//  TNMemoryTestViewController.m
//  MiraiTests
//
//  Created by Chen Yonghui on 12/27/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMemoryTestViewController.h"

@interface TNMemoryTestViewController ()
@property (nonatomic, strong) NSArray *sub;
@property (nonatomic, strong) NSArray *actions;

@end

extern void Java_org_tiny4_CocoaActivity_CocoaActivity_nativeOnTrimMemory(int level);

@implementation TNMemoryTestViewController

+ (NSString *)testName
{
    return @"Memory Test";
}

+ (void)load
{
    [self regisiterTestClass:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memwarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 100;
    [self.view addSubview:table];
    
    __weak typeof(self) weakSelf = self;
    self.actions = @[
                     [TNTestCase testCaseWithName:@"Simulate Memory Warning" action:^{
                         [weakSelf simulateMemoryWarning];
                     }],
                     [TNTestCase testCaseWithName:@"Load images" action:^{
                         [weakSelf loadImages];
                     }],
                     [TNTestCase testCaseWithName:@"Push with no animated" action:^{
                         [weakSelf pushAnimated:NO];
                     }],
                     [TNTestCase testCaseWithName:@"Push animated" action:^{
                         [weakSelf pushAnimated:YES];
                     }],
                     [TNTestCase testCaseWithName:@"animate test" action:^{
                         [weakSelf animateTest];
                     }],
                     [TNTestCase testCaseWithName:@"pop" action:^{
                         [weakSelf pop];
                     }],
                     ];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)animateTest
{
    TNMemoryTestViewController *vc = [[TNMemoryTestViewController alloc] init];
    [UIView animateWithDuration:0.2 animations:^{
        NSLog(@"vc:%@",vc);
    } completion:^(BOOL finished) {
        
    }];
    NSLog(@"vc:%@",vc);

}

- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)pushAnimated:(BOOL)animated
{
    TNTestViewController *m = [[TNTestViewController alloc] init];
    [self.navigationController pushViewController:m animated:animated];
}

- (void)loadImages
{
    UIImage *i = [UIImage imageNamed:@"ContentsGravity_Large.jpg"];

}

- (void)memwarning:(id)obj
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)simulateMemoryWarning
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
#if __ANDROID__
    Java_org_tiny4_CocoaActivity_CocoaActivity_nativeOnTrimMemory(5);
#endif    
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super didReceiveMemoryWarning];
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
