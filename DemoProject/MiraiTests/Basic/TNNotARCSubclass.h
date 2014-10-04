//
//  TNNotARCSubclass.h
//  MiraiTests
//
//  Created by Chen Yonghui on 10/3/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNNotARCSubclass : NSObject
{
    id _contents;
    id _delegate;
    
    NSString *_string1;
}
@property (nonatomic, retain) NSString * p1;

@end
