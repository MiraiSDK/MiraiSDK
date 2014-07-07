//
//  TNButtonTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 3/31/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNButtonTestViewController.h"

@interface TNButtonTestViewController ()
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;

@end

@implementation TNButtonTestViewController
+ (NSString *)testName
{
    return @"UIButton Test";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Tyoe rounded Rect" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    [self.view addSubview:button];
        
    // button press test
    //    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [b1 setTitle:@"Button" forState:UIControlStateNormal];
    //    b1.frame = CGRectMake(50, 10, 300, 150);
    //    [b1 addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [s addSubview:b1];
    
    //    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"button_search_normal" ofType:@"png"];
    //    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"button_search_pressed" ofType:@"png"];
    //    UIImage *image1 = [UIImage imageWithContentsOfFile:path1];
    //    UIImage *image2 = [UIImage imageWithContentsOfFile:path2];
    //    self.image1 = image1;
    //    self.image2 = image2;
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [button setTitle:@"Push" forState:UIControlStateNormal];
    ////    [button setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
    //    [button setBackgroundImage:image1 forState:UIControlStateNormal];
    //    [button setBackgroundImage:image2 forState:UIControlStateHighlighted];
    //    [button addTarget:self action:@selector(buttonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [button setFrame:CGRectMake(50, 200, 300, 150)];
    //    self.pushButton = button;
    //
    //    [s addSubview:button];


    //    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    popButton.frame = CGRectMake(50, 400, 300, 150);
    //    [popButton setTitle:@"Pop" forState:UIControlStateNormal];
    //    [popButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [popButton addTarget:self action:@selector(popButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [popButton setBackgroundColor:[UIColor greenColor]];
    //    [popButton addTarget:self action:@selector(buttonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [s addSubview:popButton];
    //    self.popButton = popButton;

}

- (void)didPressedButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popButtonDidPressed:(id)sender
{
    //    NSLog(@"%s",_pre);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonDidPressed:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    //    UIViewController *vc = [[UIViewController alloc] init];
    //    TNViewController *vc = [[TNViewController alloc] init];
    //    NSLog(@"navigationController:%@",self.navigationController);
    //    [self.navigationController pushViewController:vc animated:YES];
    //    [UIView beginAnimations:@"ddd" context:nil];
    //    [UIView setAnimationDuration:5];
    //    self.red.frame = CGRectMake(50, 300, 300, 150);
    //    [UIView commitAnimations];
    //    UIButton *button = self.popButton;
    
    //    if (self.imageView.image == self.image1) {
    //        self.imageView.image = self.image2;
    //        NSLog(@"set image 2");
    //    } else {
    //        self.imageView.image = self.image1;
    //        NSLog(@"set image 1");
    //    }
    //    NSLog(@"image:%@", button.imageView.image);
    //    if (CATransform3DIsIdentity(button.layer.transform)) {
    //        [button.layer setTransform:CATransform3DMakeTranslation(250, 0, 0)];
    //    } else {
    //        [button.layer setTransform:CATransform3DIdentity];
    //    }
    
    //    [self.scrollView scrollRectToVisible:CGRectMake(0, 400, 720, 500) animated:NO];
}


@end
