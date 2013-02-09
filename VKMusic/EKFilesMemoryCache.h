//
//  FileManager.h
//  ImageFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFileCache.h"

@interface EKFilesMemoryCache : NSObject <EKFileCache>
{
    NSMutableDictionary *memoryCache;
}

@end
