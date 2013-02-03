//
//  EKFilesOnDiskCache.h
//  EKFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/31/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFilesCache.h"

@interface EKFilesOnDiskCache : NSObject <EKFilesCache> {
    
}

- (id) initWithCacheSubpath:(NSString *) cacheSubpath;

@property (nonatomic, copy, readonly) NSString *cacheSubpath;

@end
