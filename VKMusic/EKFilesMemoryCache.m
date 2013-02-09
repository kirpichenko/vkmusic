//
//  FileManager.m
//  ImageFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFilesMemoryCache.h"

static EKFilesMemoryCache *kFilesMemoryCache;

@implementation EKFilesMemoryCache

+ (id) currentCache
{
    return kFilesMemoryCache;
}

+ (void) setCurrentCache:(id<EKFileCache>) cache
{
    if (cache != kFilesMemoryCache) {
        [kFilesMemoryCache release];
        kFilesMemoryCache = [cache retain];
    }
}

- (id) init
{
    if (self = [super init]) {
        memoryCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) dealloc
{
    if (self == kFilesMemoryCache) {
        kFilesMemoryCache = nil;
    }
    [memoryCache release];
    [super dealloc];
}

#pragma mark -
#pragma mark storing files

- (void) cacheFileData:(NSData *) fileData forKey:(NSString *) key
{
    [memoryCache setObject:fileData forKey:key];
}

- (NSData *) cachedFileDataForKey:(NSString *) key
{
    return [memoryCache objectForKey:key];
}

- (BOOL) hasCachedFileForKey:(NSString *) key
{
    return ([memoryCache objectForKey:key] != nil);
}

#pragma mark -
#pragma mark cleaning

- (void) cleanCache
{
    [memoryCache removeAllObjects];
}

- (void) deleteFileForKey:(NSString *) key
{
    [memoryCache removeObjectForKey:key];
}

@end
