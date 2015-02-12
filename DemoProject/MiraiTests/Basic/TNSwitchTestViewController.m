//
//  TNSwitchTestViewController.m
//  MiraiTests
//
//  Created by TaoZeyu on 15/2/2.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNSwitchTestViewController.h"

@interface TNSwitchTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *tests;
@property (nonatomic, strong) UISwitch *switchItem;
@end

@implementation TNSwitchTestViewController

+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"UISwitch Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(45, 120, 172, 96);
    
    self.switchItem = [[UISwitch alloc] initWithFrame:rect];
    [self.switchItem addTarget:self
                   action:@selector(_changeSwitch:)
         forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.switchItem ];
    
    UIBarButtonItem *item  = [[UIBarButtonItem alloc] initWithTitle:@"Set Switch On" style:UIBarButtonItemStylePlain target:self action:@selector(_clickButton:)];
    self.navigationItem.rightBarButtonItems = @[item];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(void) _changeSwitch:(id)sender
{
    if([sender isOn]){
        NSLog(@"Switch is on");
    } else{
        NSLog(@"Switch is off");
    }
}

-(void) _clickButton:(id)sender
{
    [self.switchItem setOn:YES animated:YES];
}

@end
