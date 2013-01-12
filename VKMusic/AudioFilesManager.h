//
//  AudioFilesManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKFilesOnDiskCache;
@protocol AudioLoaderDelegate;

@interface AudioFilesManager : NSObject {
    EKFilesOnDiskCache *filesCache;
}

+ (id) sharedInstance;

- (void) audioFileFromURL:(NSURL *) url delegate:(id<AudioLoaderDelegate>) delegate;

@end
