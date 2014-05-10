//
//  NBBrowserViewController.h
//  NextBook
//
//  Created by yifan on 3/28/13.
//  Copyright (c) 2013 Shanghai TinyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBBrowserViewController : UIViewController //<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndecator;
- (void) openURL:(NSURL *)url;
- (id)init;

@end
