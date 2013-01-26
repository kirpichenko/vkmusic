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
static NSString *kPlayingIndexKey = @"playingIndex";

@interface AudioPlayer () <AVAudioPlayerDelegate>
@property (nonatomic, strong) AVPlayer *currentPlayer;
@end

@implementation AudioPlayer

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
        _state = kAudioPlayerStateUnconfigured;
        _playingIndex = NSNotFound;
        
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

- (void) setAudioList:(NSArray *)audioList
{
    if (_state != kAudioPlayerStateUnconfigured) {
        [self stop];
    }    
    
    _audioList = [audioList copy];
    _playingIndex = NSNotFound;
    _state = kAudioPlayerStateReady;
}

#pragma mark -
#pragma mark audio playing

- (void) play
{
    if (_state != kAudioPlayerStatePlaying) {
        [self playAudioAtIndex:0];
    }
}

- (void) playAudioAtIndex:(NSInteger) index
{
    if ([_audioList count] > 0 && index < [_audioList count]) {
        _state = kAudioPlayerStatePlaying;
        _playingIndex = index;
        
        [self willChangeValueForKey:kPlayingAudioKey];
        _playingAudio = [[self audioList] objectAtIndex:index];
        [self didChangeValueForKey:kPlayingAudioKey];
        
#ifndef TEST
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[_playingAudio url]];
        
        AVPlayer *player = [self currentPlayer];
        if (player == nil) {
            player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
            [self setCurrentPlayer:player];
        }
        
        [player replaceCurrentItemWithPlayerItem:playerItem];
        [player play];
#endif
    }
}

- (void) playNextAudio
{
    if (_playingIndex != NSNotFound) {
        NSInteger nextAudioIndex = (_playingIndex + 1) % [[self audioList] count];
        [self playAudioAtIndex:nextAudioIndex];
    }    
}

- (void) playPreviousAudio
{
    if (_playingIndex != NSNotFound) {
        NSInteger auidoCount = [[self audioList] count];
        NSInteger previousAudioIndex = (_playingIndex + auidoCount - 1) % auidoCount;
        [self playAudioAtIndex:previousAudioIndex];
    }
}

- (void) resume
{
    if (_state == kAudioPlayerStatePaused) {
        _state = kAudioPlayerStatePlaying;
        [[self currentPlayer] play];
    }
}

- (void) pause {
    if (_state == kAudioPlayerStatePlaying) {
        _state = kAudioPlayerStatePaused;
        [[self currentPlayer] pause];
    }
}

- (void) stop
{
    [_currentPlayer pause];
    _currentPlayer = nil;

    _state = kAudioPlayerStateUnconfigured;
    _audioList = nil;
    _playingIndex = NSNotFound;
    _playingAudio = nil;
}

- (NSTimeInterval) currentTime
{
    AVPlayer *player = [self currentPlayer];
    if (player != nil) {
        CMTime currentTime = [player currentTime];
        NSTimeInterval seconds = currentTime.value / currentTime.timescale;
        return seconds;
    }
    return 0;
}

#pragma mark -
#pragma mark AVPlayer handle notifications

- (void) playingFinished
{
    [self playNextAudio];
}

@end
