//
//  EKFilesCache.h
//  EKFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/31/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EKFileCache <NSObject>

+ (id) currentCache;
+ (void) setCurrentCache:(id<EKFileCache>) cache;

- (NSData *) cachedFileDataForKey:(NSString *) key;
- (BOOL) hasCachedFileForKey:(NSString *) key;

- (void) cacheFileData:(NSData *) fileData forKey:(NSString *) key;
- (void) deleteFileForKey:(NSString *) key;
- (void) cleanCache;

@end
