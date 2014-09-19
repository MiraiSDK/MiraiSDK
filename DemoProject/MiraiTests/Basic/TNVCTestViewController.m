//
//  TNVCTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/18/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNVCTestViewController.h"

#import "TNPresentedContentViewController.h"
#import "TNPresentTestViewController.h"

@interface TNNavigationController : UINavigationController

@end
@implementation TNNavigationController

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
@interface TNVCTestViewController () <UITableViewDataSource,UITableViewDelegate,TNPresentedContentViewControllerDelegate,TNPresentTestViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tests;
@end

@implementation TNVCTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"View Controller Test";
}

- (NSString *)testDescription
{
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tests = @[
                   [TNTestCase testCaseWithName:@"presentViewController with nav" action:^{
                       // present nav
                       [self presentVCWithOrientation:UIInterfaceOrientationMaskLandscape];
                   }],

                   [TNTestCase testCaseWithName:@"NavigationBar Show/Hidden" action:^{
                       [self.navigationController setNavigationBarHidden:!self.navigationController.isNavigationBarHidden];
                   }],

                   [TNTestCase testCaseWithName:@"NavigationBar Show/Hidden animated" action:^{
                       [self.navigationController setNavigationBarHidden:!self.navigationController.isNavigationBarHidden animated:YES];
                   }],
                   
                   [TNTestCase testCaseWithName:@"presentViewController with portrait nav" action:^{
                       // present nav
                       [self presentVCWithOrientation:UIInterfaceOrientationMaskPortrait];
                   }],

                   [TNTestCase testCaseWithName:@"present test" action:^{
                       TNPresentTestViewController *vc = [[TNPresentTestViewController alloc] init];
                       vc.delegate = self;
                       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                       [self presentViewController:nav animated:YES completion:nil];
                   }],
//
//                   [TNTestCase testCaseWithName:@"presentViewController with nav" action:^{
//                       // present nav
//                       [self presentVCWithOrientation:UIInterfaceOrientationMaskLandscape];
//                   }],

                   ];
    
    
}


- (void)presentVCWithOrientation:(NSUInteger)orientation
{
    // present nav
    TNPresentedContentViewController * vc = [[TNPresentedContentViewController alloc] init];
    vc.delegate = self;
    vc.orientation = orientation;
    TNNavigationController *nav = [[TNNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)presentTestViewControllerDidCancel:(TNPresentTestViewController *)vc animated:(BOOL)animated
{
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void)presentedContentViewControllerDidCancel:(TNPresentedContentViewController *)vc animated:(BOOL)animated
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    cell.textLabel.text = [self.tests[indexPath.row] name];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTestCase *t = self.tests[indexPath.row];
    t.action();
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
