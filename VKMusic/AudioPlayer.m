//
//  AudioPlayer.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioPlayer.h"

#import <AVFoundation/AVFoundation.h>

static NSString *kPlayingAudioKey = @"playingAudio";

@interface AudioPlayer () <AVAudioPlayerDelegate>
@end

@implementation AudioPlayer

@synthesize state;
@synthesize playingIndex;
@synthesize playingAudio;
@synthesize audioList;

+ (id) sharedInstance
{
    static AudioPlayer *audioPlayer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioPlayer = [[AudioPlayer alloc] init];
    });
    return audioPlayer;
}

- (id) init
{
    if (self = [super init]) {
        player = [[AVPlayer alloc] init];

        state = kAudioPlayerStateUnconfigured;
        playingIndex = NSNotFound;
        
        [self configureAudioSession];
        [self observeNotificationNamed:AVPlayerItemDidPlayToEndTimeNotification
                          withSelector:@selector(playingFinished)];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark set list

- (void) setAudioList:(NSArray *)anAudioList
{
    if (state != kAudioPlayerStateUnconfigured) {
        [self stop];
    }    
    
    audioList = [anAudioList copy];
    playingIndex = NSNotFound;
    state = kAudioPlayerStateReady;
}

#pragma mark -
#pragma mark audio playing

- (void) play
{
    if (state != kAudioPlayerStatePlaying) {
        [self playAudioAtIndex:0];
    }
}

- (void) playAudioAtIndex:(NSInteger) index
{
    NSLog(@"play at index %d",index);
    if ([audioList count] > 0 && index < [audioList count]) {
        state = kAudioPlayerStatePlaying;
        playingIndex = index;
        
        [self willChangeValueForKey:kPlayingAudioKey];
        playingAudio = [[self audioList] objectAtIndex:index];
        [self didChangeValueForKey:kPlayingAudioKey];
        
#ifndef TEST
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[playingAudio url]];
        [player replaceCurrentItemWithPlayerItem:playerItem];
        [player play];
        
        if ([player error] != nil) {
            NSLog(@"playing error = %@",[[player error] localizedDescription]);
        }
#endif
    }
}

- (void) playNextAudio
{
    if (playingIndex != NSNotFound) {
        NSInteger nextAudioIndex = (playingIndex + 1) % [[self audioList] count];
        [self playAudioAtIndex:nextAudioIndex];
    }    
}

- (void) playPreviousAudio
{
    if (playingIndex != NSNotFound) {
        NSInteger auidoCount = [[self audioList] count];
        NSInteger previousAudioIndex = (playingIndex + auidoCount - 1) % auidoCount;
        [self playAudioAtIndex:previousAudioIndex];
    }
}

- (void) resume
{
    if (state == kAudioPlayerStatePaused) {
        state = kAudioPlayerStatePlaying;
        [player play];
    }
}

- (void) pause {
    if (state == kAudioPlayerStatePlaying) {
        state = kAudioPlayerStatePaused;
        [player pause];
    }
}

- (void) stop
{
    [player pause];

    state = kAudioPlayerStateUnconfigured;
    audioList = nil;
    playingIndex = NSNotFound;
    playingAudio = nil;
}

- (NSTimeInterval) currentTime
{
    CMTime currentTime = [player currentTime];
    NSTimeInterval seconds = currentTime.value / currentTime.timescale;
    return seconds;
}

#pragma mark -
#pragma mark AVPlayer handle notifications

- (void) playingFinished
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self playNextAudio];
	});
    NSLog(@"playing finished");
    
}

#pragma mark -
#pragma mark helpers

- (void)configureAudioSession
{
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    if (error != nil) {
        NSLog(@"Set asudio session category error:%@",[error localizedDescription]);
    }

    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

@end
