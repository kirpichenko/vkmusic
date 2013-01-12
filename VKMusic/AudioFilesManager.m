//
//  AudioFilesManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioFilesManager.h"
#import "EKFilesOnDiskCache.h"
#import "EKFilesLoader.h"
#import "AudioFileLoadingAdapter.h"

@interface AudioFilesManager () <EKFilesLoaderDelegate>

@end

@implementation AudioFilesManager

+ (id) sharedInstance
{
    static AudioFilesManager *filesManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filesManager = [[AudioFilesManager alloc] init];
    });
    return filesManager;
}

- (void) audioFileFromURL:(NSURL *) url delegate:(id<AudioLoaderDelegate>) delegate
{
    
}


@end
