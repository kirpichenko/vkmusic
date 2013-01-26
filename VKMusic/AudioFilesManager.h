//
//  AudioFilesManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFileManager.h"
#import "AudioFileLoadingAdapter.h"

@class EKFilesOnDiskCache;

@interface AudioFilesManager : NSObject {
    EKFilesOnDiskCache *filesCache;
    EKFileManager *filesManager;
}

+ (id) sharedInstance;

- (void) audioFileFromURL:(NSURL *) url delegate:(id<AudioLoaderDelegate>) delegate;

@end
