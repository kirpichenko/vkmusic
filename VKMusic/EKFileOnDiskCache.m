//
//  EKFilesOnDiskCache.m
//  EKFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/31/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFileOnDiskCache.h"
#import "NSString+Hash.h"

static NSString * const kDefaultSubdirectory = @"FilesCache";
static EKFileOnDiskCache *kFilesOnDiskCache = nil;

@interface EKFileOnDiskCache ()
@property (nonatomic,copy,readwrite) NSString *cacheSubpath;
@end

@implementation EKFileOnDiskCache

#pragma mark -
#pragma mark life cycle

+ (id) currentCache
{
    return kFilesOnDiskCache;
}

+ (void) setCurrentCache:(id<EKFileCache>) cache
{
    if (cache != kFilesOnDiskCache) {
        [kFilesOnDiskCache release];
        kFilesOnDiskCache = [cache retain];
    }
}

- (id) initWithCacheSubpath:(NSString *) cacheSubpath
{
    if (self = [super init]) {
        [self setCacheSubpath:cacheSubpath];
        
        NSString *cachesDirectory = [self pathForCachesDirectory];
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cachesDirectory
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        }
    }
    return self;
}

- (id) init
{
    return [self initWithCacheSubpath:nil];
}

- (void) dealloc
{
    if (self == kFilesOnDiskCache) {
        kFilesOnDiskCache = nil;
    }
    [self setCacheSubpath:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark paths

- (NSString *) pathForCachesDirectory
{
    NSArray* caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *subpath = [kDefaultSubdirectory stringByAppendingPathComponent:[self cacheSubpath]];
    return [[caches lastObject] stringByAppendingPathComponent:subpath];
}

- (NSString *) cachePathForKey:(NSString *)key
{
    NSString *keyhash = [key md5];
    return [[self pathForCachesDirectory] stringByAppendingPathComponent:keyhash];
}

#pragma mark -
#pragma mark store files

- (void) cacheFileData:(NSData *) fileData forKey:(NSString *) key
{
    NSString *filePath = [self cachePathForKey:key];
    [[NSFileManager defaultManager] createFileAtPath:filePath
                                            contents:fileData
                                          attributes:nil];
}

- (NSData *) cachedFileDataForKey:(NSString *) key
{
    NSString *filePath = [self cachePathForKey:key];
    return [NSData dataWithContentsOfFile:filePath];
}

- (BOOL) hasCachedFileForKey:(NSString *) key
{
    NSString *filePath = [self cachePathForKey:key];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

#pragma mark -
#pragma mark clean cache

- (void) cleanCache
{
    NSError *error = nil;
    NSString *cacheDirectory = [self pathForCachesDirectory];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cacheDirectory
                                                                         error:&error];
    if (error == nil && [files count] > 0) {
        for (NSString *filename in files) {
            NSString *filePath = [cacheDirectory stringByAppendingPathComponent:filename];
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

- (void) deleteFileForKey:(NSString *) key
{
    [[NSFileManager defaultManager] removeItemAtPath:[self cachePathForKey:key]
                                               error:nil];
}

@end
