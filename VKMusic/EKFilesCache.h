//
//  EKFilesCache.h
//  EKFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/31/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EKFilesCache <NSObject>

+ (id) currentCache;
+ (void) setCurrentCache:(id<EKFilesCache>) cache;

- (void) cacheFileData:(NSData *) fileData forKey:(NSString *) key;
- (NSData *) cachedFileDataForKey:(NSString *) key;
- (void) deleteFileForKey:(NSString *) key;
- (void) cleanCache;

@end
