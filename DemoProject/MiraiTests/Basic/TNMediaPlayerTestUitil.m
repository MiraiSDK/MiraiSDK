//
//  TNMediaPlayerTestUitil.m
//  MiraiTests
//
//  Created by TaoZeyu on 15/4/21.
//  Copyright (c) 2015年 Shanghai Tinynetwork. All rights reserved.
//

#import "TNMediaPlayerTestUitil.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation TNMediaPlayerTestUitil

+ (NSURL *)URLWithResourceName:(NSString *)name withExtension:(NSString *)extension
{
    NSURL *url = [self _getResourceURLFromMainBundleWithName:name withExtension:extension];
    name = [NSString stringWithFormat:@"%@.%@", name, extension];
    if (!url) {
        url = [self _getResourceURLFromDocumentsWithName:name];
    }
    if (!url) {
        url = [self _getResourceURLromAbsolutePathWithName:name];
    }
    return url;
}


+ (NSURL *)_getResourceURLFromMainBundleWithName:(NSString *)name withExtension:(NSString *)extension
{
    return [[NSBundle mainBundle] URLForResource:name withExtension:extension];
}

+ (NSURL *)_getResourceURLFromDocumentsWithName:(NSString *)name
{
    NSURL *document = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [document URLByAppendingPathComponent:name];
}

+ (NSURL *)_getResourceURLromAbsolutePathWithName:(NSString *)name
{
    return [[NSURL alloc] initWithString:[NSString stringWithFormat:@"file://localhost/storage/emulated/legacy/Android/data/org.tiny4.MiraiTests/org.tiny4.MiraiTests.app/%@", name]];
}

@end
