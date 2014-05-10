//
//  TNScrollTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 4/9/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNScrollTestViewController.h"

@interface TNScrollTestViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *red;

@end

@implementation TNScrollTestViewController
+ (NSString *)testName
{
    return @"Scroll Test";
}

//+ (void)initialize
//{
//    [self registerTestCase];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *s = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    s.backgroundColor = [UIColor whiteColor];
    
    s.contentSize = CGSizeMake(self.view.bounds.size.width*2,
                               self.view.bounds.size.height);
    
    [self.view addSubview:s];
    self.scrollView = s;
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(50, 250, 300, 150)];
    red.backgroundColor = [UIColor redColor];
    self.red = red;
    [self.scrollView addSubview:red];
    
    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*2-50-300, 250, 300, 150)];
    green.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:green];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
