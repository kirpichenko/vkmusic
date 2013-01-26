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
    static AudioFilesManager *audioFilesManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioFilesManager = [[AudioFilesManager alloc] init];
    });
    return audioFilesManager;
}

- (id) init
{
    if (self = [super init]) {
        filesCache = [[EKFilesOnDiskCache alloc] initWithCacheSubpath:@"Music"];
        filesManager = [[EKFileManager alloc] initWithCache:filesCache];
    }
    return self;
}

#pragma mark -
#pragma mark adaptee method

- (void) audioFileFromURL:(NSURL *) url delegate:(id<AudioLoaderDelegate>) delegate
{
    AudioFileLoadingAdapter *adapter = [[AudioFileLoadingAdapter alloc] initWithDelegate:delegate];
    [filesManager getFileFromURL:url delegate:adapter];
}


@end
