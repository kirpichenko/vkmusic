//
//  FileManager.h
//  ImageFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFilesCache.h"

@interface EKFilesMemoryCache : NSObject <EKFilesCache> {
    NSMutableDictionary *memoryCache;
}

@end
