//
//  TNTestCase.h
//  BasicCairo
//
//  Created by Chen Yonghui on 8/7/14.
//  Copyright (c) 2014 Shanghai Tinynetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TestAction)(void);

@interface TNTestCase : NSObject
- (instancetype)initWithName:(NSString *)name action:(TestAction)action;
+ (instancetype)testCaseWithName:(NSString *)name action:(TestAction)action;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) TestAction action;
@end
