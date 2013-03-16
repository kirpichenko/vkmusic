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
@property (nonatomic,copy) NSString *cachePath;
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

- (id) initWithCachePath:(NSString *)cachePath
{
    if (self = [super init]) {
        [self setCachePath:cachePath];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cachePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        }
    }
    return self;
}

- (id) init
{
    return [self initWithCachePath:[[self class] pathForCachesDirectory]];
}

- (void) dealloc
{
    if (self == kFilesOnDiskCache) {
        kFilesOnDiskCache = nil;
    }
    [self setCachePath:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark paths

+ (NSString *) pathForCachesDirectory
{
    return [self pathForDirectory:NSCachesDirectory];
}

+ (NSString *)pathForDocumentsDirectory
{
    return [self pathForDirectory:NSDocumentDirectory];
}

- (NSString *) filePathForKey:(NSString *)key
{
    NSString *keyhash = [NSString stringWithFormat:@"%@.%@",[key md5],[key pathExtension]];
    return [[self cachePath] stringByAppendingPathComponent:keyhash];
}

#pragma mark -
#pragma mark store files

- (void) cacheFileData:(NSData *) fileData forKey:(NSString *) key
{
    NSString *filePath = [self filePathForKey:key];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:nil];
    [self addSkipBackupAttributeToFileAtPath:filePath];
}

- (NSData *) cachedFileDataForKey:(NSString *) key
{
    NSString *filePath = [self filePathForKey:key];
    return [NSData dataWithContentsOfFile:filePath];
}

- (BOOL) hasCachedFileForKey:(NSString *) key
{
    NSString *filePath = [self filePathForKey:key];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

#pragma mark -
#pragma mark clean cache

- (void) cleanCache
{
    NSError *error = nil;
    NSString *cacheDirectory = [self cachePath];
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
    [[NSFileManager defaultManager] removeItemAtPath:[self filePathForKey:key]
                                               error:nil];
}

#pragma mark -
#pragma mark helpers

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory
{
    NSArray* caches = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    return [caches lastObject];
}

- (void)addSkipBackupAttributeToFileAtPath:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSError *error;
        NSURL *fileURL = [NSURL URLWithString:filePath];
        BOOL success = [fileURL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey
                                           error:&error];
        if (!success)
        {
            NSLog(@"Error excluding %@ from backup %@", fileURL, error);
        }
    }
}

@end
