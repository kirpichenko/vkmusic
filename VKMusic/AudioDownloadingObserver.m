//
//  AudioFileLoader.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioDownloadingObserver.h"
#import "EKDownloader.h"

@interface AudioDownloadingObserver ()
@property (nonatomic, strong) id<AudioDownloadingDelegate> delegate;
@property (nonatomic, strong) OnlineAudio *audio;
@end

@implementation AudioDownloadingObserver

#pragma mark -
#pragma mark life cycle

- (id) initWithDelegate:(id<AudioDownloadingDelegate>) delegate audio:(OnlineAudio *) audio
{
    if (self = [super init]) {
        [self setDelegate:delegate];
    }
    return self;
}

- (void) dealloc
{
    [self setDelegate:nil];
}

#pragma mark -
#pragma mark EKDownloaderDelegate

- (void) downloadingFinished:(EKDownloader *) loader
{
    if ([[self delegate] respondsToSelector:@selector(audioFileLoaded:)]) {
        [[self delegate] audioFileLoaded:[self audio]];
    }
}

- (void) downloading:(EKDownloader *) loader inProgress:(NSInteger) progress
{
    if ([[self delegate] respondsToSelector:@selector(audioFile:loadingInProgress:)]) {
        [[self delegate] audioFile:[self audio] loadingInProgress:progress];
    }
}

- (void) downloadingFailed:(EKDownloader *) loader
{
    if ([[self delegate] respondsToSelector:@selector(audioFile:loadingFailed:)]) {
        [[self delegate] audioFile:[self audio] loadingFailed:[loader error]];
    }
}

#pragma mark -
#pragma mark equal

- (BOOL) isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [[object delegate] isEqual:[self delegate]];
    }
    return NO;
}

@end
