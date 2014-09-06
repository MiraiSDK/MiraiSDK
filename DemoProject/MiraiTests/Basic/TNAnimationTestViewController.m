//
//  TNAnimationTestViewController.m
//  BasicCairo
//
//  Created by Chen Yonghui on 7/5/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import "TNAnimationTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TNAnimationTestViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) CALayer *quadLayer;
@property (nonatomic, strong) UIView *quadView;
@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) NSArray *tests;
@end
@implementation TNAnimationTestViewController
+ (void)load
{
    [self regisiterTestClass:self];
}

+ (NSString *)testName
{
    return @"Animation";
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
                   @[@"Test animation override", NSStringFromSelector(@selector(testAnimationOverride))],
                   @[@"Test alpha animation", NSStringFromSelector(@selector(testAlphaAnimation))],
                  ];
    
    //
    //    CALayer *quad = [CALayer layer];
    //    quad.frame = CGRectMake(0, 0, 200, 200);
    //    quad.backgroundColor = [UIColor redColor].CGColor;
    //    [self.view.layer addSublayer:quad];
    //    self.quadLayer = quad;
    
    //    UIView *quadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    quadView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    //    [self.view addSubview:quadView];
    //    self.quadView = quadView;
    
    
    //    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    animationView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //    [self.view addSubview:animationView];
    //    self.animationView = animationView;
    
    //
    //    CALayer *subQuad = [CALayer layer];
    //    subQuad.frame = CGRectMake(50, 50, 100, 100);
    //    subQuad.backgroundColor = [UIColor greenColor].CGColor;
    //    [quad addSublayer:subQuad];
    //
    //    quad.shouldRasterize = YES;
    //
    //    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    //    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    //    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(600, 600)];
    //    ani.repeatCount = HUGE_VALF;
    //    ani.autoreverses = YES;
    //    ani.duration = 1;
    //    [quad addAnimation:ani forKey:@"move"];

}

- (UIImage *)imageNamed:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:data];
    return image;
}

- (void)testAlphaAnimation
{
    UIImage *image = [self imageNamed:@"testImage" type:@"jpg"];
    NSLog(@"image:%@",image);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    v.backgroundColor = [UIColor redColor];
//    [self.view addSubview:v];

    
    [UIView animateWithDuration:4 animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)testAnimationOverride
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani1.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    ani1.delegate = self;
    ani1.duration = 5;
    [v.layer addAnimation:ani1 forKey:@"position"];
    
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani2.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    ani2.delegate = self;
    ani2.duration = 5;
    [v.layer addAnimation:ani2 forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%s animation:%@ finished:%d",__PRETTY_FUNCTION__,anim,flag);
}

- (void)testAnimation
{
    
    //    CGFloat width = CGRectGetWidth(self.view.bounds);
    //    CGFloat height = CGRectGetHeight(self.view.bounds);
    //
    //    CGFloat randomX = arc4random()%(NSInteger)width;
    //    CGFloat randomY = arc4random()%(NSInteger)height;
    //
    //    CGPoint randomPoint = CGPointMake(randomX, randomY);
    //    CGPoint prevPoint = self.quadView.center;
    
    //    NSLog(@"move to point:%@",NSStringFromCGPoint(randomPoint));
    
    //    [UIView animateWithDuration:5 animations:^{
    //        self.animationView.center = randomPoint;
    //    }];
    //
    //    self.quadLayer.position = randomPoint;
    
    //    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    //    ani.toValue = [NSValue valueWithCGPoint:randomPoint];
    //    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    ani.duration = 5;
    //    [self.quadView.layer addAnimation:ani forKey:@"Move"];
    //
    //    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"position"];
    //    ani1.toValue = [NSValue valueWithCGPoint:randomPoint];
    //    ani1.duration = 5;
    //    [self.quadLayer addAnimation:ani1 forKey:@"Move"];
    
    //NSLog(@"ani:%@",ani);
    //NSLog(@"ani1:%@",ani1);
    //    NSLog(@"view animations:%@",self.animationView.layer);
    
    
    //    CGPoint originCenter = CGPointMake(CGRectGetMidX(self.view.bounds),
    //                                       CGRectGetMidY(self.view.bounds));
    //    CGPoint center = self.quadView.center;
    //    if (CGPointEqualToPoint(originCenter, center)) {
    //        center.x += 200;
    //        center.y += 200;
    //    } else {
    //        center = originCenter;
    //    }
    //    [UIView animateWithDuration:5 animations:^{
    //        self.quadView.center = center;
    //    }];
    //
    //    self.quadLayer.position = center;

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
    
    cell.textLabel.text = self.tests[indexPath.row][0];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *test = self.tests[indexPath.row];
    SEL selector = NSSelectorFromString(test[1]);
    if (selector && [self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
