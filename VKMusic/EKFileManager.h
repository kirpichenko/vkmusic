//
//  EKFileManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EKFilesLoaderDelegate.h"
#import "EKFilesCache.h"

@interface EKFileManager : NSObject
{
    NSMutableArray *loadingQueue;
}

- (id) initWithCache:(id<EKFilesCache>) cache;

- (void) getFileFromURL:(NSURL *) url delegate:(id<EKFilesLoaderDelegate>) delegate;

@end
