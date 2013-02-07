//
//  AudioFilesManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OfflineAudioManager.h"

#import "EKFileOnDiskCache.h"
#import "EKFileManager.h"

#import "AudioDownloaderAdapter.h"

@interface OfflineAudioManager ()

@end

@implementation OfflineAudioManager

+ (id) sharedInstance
{
    static OfflineAudioManager *audioFilesManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioFilesManager = [[OfflineAudioManager alloc] init];
    });
    return audioFilesManager;
}

- (id) init
{
    if (self = [super init]) {
        fileCache = [[EKFileOnDiskCache alloc] initWithCacheSubpath:@"Music"];
        fileManager = [[EKFileManager alloc] initWithCache:fileCache];
    }
    return self;
}

#pragma mark -
#pragma mark instance methods

- (void) loadAudio:(OnlineAudio *) audio
{
    [self loadAudio:audio delegate:nil];
}

- (void) loadAudio:(OnlineAudio *) audio delegate:(id<AudioDownloaderDelegate>) delegate
{
    NSURL *audioURL = [audio url];
    if ([fileCache hasCachedFileForKey:[audioURL absoluteString]]) {
        if ([delegate respondsToSelector:@selector(audioFile:saved:)]) {
            NSData *cachedData = [fileCache cachedFileDataForKey:[audioURL absoluteString]];
            [delegate audioFile:audio saved:cachedData];
        }
    }
    else {
        AudioDownloaderAdapter *adapter = [[AudioDownloaderAdapter alloc] initWithOnlineAudio:audio
                                                                                     delegate:delegate];
        [fileManager loadFile:audioURL delegate:adapter];
    }
}

- (void) deleteAudio:(OfflineAudio *) audio
{
    [fileCache deleteFileForKey:[[audio url] absoluteString]];
}

@end
