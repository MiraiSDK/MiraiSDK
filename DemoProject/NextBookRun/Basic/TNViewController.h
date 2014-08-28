//
//  TNViewController.h
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (BOOL)handleOpenURL:(NSURL *)url;
@property (nonatomic, strong) NSURL *baseURL;

@end
