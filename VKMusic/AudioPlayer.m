//
//  AudioPlayer.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioPlayer.h"

#import <AVFoundation/AVFoundation.h>

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
    [_currentPlayer pause];
}

- (void) playAudioAtIndex:(NSInteger) index
{
    if ([_audioList count] > 0 && index < [_audioList count]) {
        _playingIndex = index;
        
        Audio *audio = [[self audioList] objectAtIndex:index];
        AVPlayer *player = [[AVPlayer alloc] initWithURL:[audio url]];
        [self setCurrentPlayer:player];
        [player play];
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
    [[self currentPlayer] play];
}

- (void) pause {
    [[self currentPlayer] pause];
}

- (void) stop
{
    [_currentPlayer pause];
    _currentPlayer = nil;
    _state = kAudioPlayerStateUnconfigured;
    _audioList = nil;
}


#pragma mark -
#pragma mark AVPlayer handle notifications

- (void) playingFinished
{
    [self playNextAudio];
    NSLog(@"finished");
}

@end
