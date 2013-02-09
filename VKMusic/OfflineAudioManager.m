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

@interface OfflineAudioManager () <AudioDownloaderDelegate>

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
        [fileManager loadFile:audioURL delegate:[self adapterForAudio:audio delegate:delegate]];
        [fileManager loadFile:audioURL delegate:[self adapterForAudio:audio delegate:self]];
    }
}

- (NSArray *) offlineAudioList
{
    return [OfflineAudio MR_findAllSortedBy:@"artist" ascending:YES];
}

- (NSArray *) offlineAudioListWithFilter:(NSString *) filter
{
    if ([filter length] == 0) {
        return [self offlineAudioList];
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"artist contains[cd] %@ or title contains[cd] %@",filter,filter];
    return [OfflineAudio MR_findAllSortedBy:@"artist" ascending:YES withPredicate:predicate];
}

#pragma mark -
#pragma mark AudioDownloaderDelegate

- (void) audioFile:(OnlineAudio *) audio saved:(NSData *) audioData
{
    [self saveAudio:audio];
}

#pragma mark -
#pragma mark helpers

- (AudioDownloaderAdapter *) adapterForAudio:(OnlineAudio *) audio
                                    delegate:(id<AudioDownloaderDelegate>) delegate
{
    return [[AudioDownloaderAdapter alloc] initWithOnlineAudio:audio
                                                      delegate:delegate];
}

- (void) saveAudio:(OnlineAudio *) audio
{
    OfflineAudio *offlineAudio = [OfflineAudio MR_createEntity];
    
    [offlineAudio setArtist:[audio artist]];
    [offlineAudio setTitle:[audio title]];
    [offlineAudio setAudioID:[audio audioID]];
    [offlineAudio setAudioURL:[fileCache filePathForKey:[[audio url] absoluteString]]];
    [offlineAudio setDuration:[audio duration]];

    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfAndWait];
}

@end
