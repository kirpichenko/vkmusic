//
//  EKFilesOnDiskCache.h
//  EKFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/31/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFileCache.h"

@interface EKFileOnDiskCache : NSObject <EKFileCache>

- (id) initWithCacheSubpath:(NSString *) cacheSubpath;

@property (nonatomic, copy, readonly) NSString *cacheSubpath;

@end
