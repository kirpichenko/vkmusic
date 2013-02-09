//
//  AudioFileLoader.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioDownloaderAdapter.h"
#import "EKFileDownloader.h"

@interface AudioDownloaderAdapter ()
@property (nonatomic,retain,readwrite) id<AudioDownloaderDelegate> delegate;
@property (nonatomic,retain,readwrite) OnlineAudio *audio;
@end

@implementation AudioDownloaderAdapter

@synthesize delegate;
@synthesize audio;

#pragma mark -
#pragma mark life cycle

- (id) initWithOnlineAudio:(OnlineAudio *) anAudio
                  delegate:(id<AudioDownloaderDelegate>) aDelegate
{
    if (self = [super init]) {
        [self setDelegate:aDelegate];
        [self setAudio:anAudio];
    }
    return self;
}

- (void) dealloc
{
    [self setAudio:nil];
    [self setDelegate:nil];
}

#pragma mark -
#pragma mark EKDownloaderDelegate

- (void) downloadingFinished:(EKFileDownloader *) loader
{
    if ([delegate respondsToSelector:@selector(audioFile:saved:)]) {
        [delegate audioFile:audio saved:[loader response]];
    }
}

- (void) downloading:(EKFileDownloader *) loader inProgress:(float) progress
{
    if ([delegate respondsToSelector:@selector(audioFile:loadingInProgress:)]) {
        [delegate audioFile:audio loadingInProgress:progress];
    }
}

- (void) downloadingFailed:(EKFileDownloader *) loader
{
    if ([delegate respondsToSelector:@selector(audioFile:loadingFailed:)]) {
        [delegate audioFile:audio loadingFailed:[loader error]];
    }
}

#pragma mark -
#pragma mark equal

- (BOOL) isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return ([[object delegate] isEqual:delegate] &&
                [[object audio] isEqual:audio]);
    }
    return NO;
}

@end
