//
//  NBBookLib+Auth.h
//  NBBookLib+Auth
//
//  Created by Chen Yonghui on 1/25/13.
//  Copyright (c) 2013 Shanghai TinyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBBookLib : NSObject
+ (BOOL)authWithDeveloperID:(NSString *)developerID key:(NSString *)key;
+ (BOOL)isAuthorized;

+ (NSString *)version;
@end
