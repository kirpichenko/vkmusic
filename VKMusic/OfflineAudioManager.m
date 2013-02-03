//
//  AudioFilesManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OfflineAudioManager.h"

#import "EKFilesOnDiskCache.h"
#import "EKDownloader.h"

#import "AudioDownloadingObserver.h"


@interface OfflineAudioManager () <AudioDownloadingDelegate>

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
        filesCache = [[EKFilesOnDiskCache alloc] initWithCacheSubpath:@"Music"];
        downloaders = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark instance methods

- (void) saveAudio:(OnlineAudio *) audio
{
    [self saveAudio:audio delegate:nil];
}

- (void) saveAudio:(OnlineAudio *) audio delegate:(id<AudioDownloadingDelegate>) delegate
{
    AudioDownloadingObserver *observer = [[AudioDownloadingObserver alloc] initWithDelegate:delegate
                                                                                      audio:audio];
    EKDownloader *downloader = [[EKDownloader alloc] initWithURL:[audio url]];
    [downloader registerObserver:observer];
    [downloader start];
}

- (void) deleteAudio:(OfflineAudio *) audio
{
    NSLog(@"delete");
}

#pragma mark -
#pragma mark helpers



@end
