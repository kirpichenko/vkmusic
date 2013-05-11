//
//  AudioPlayer.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Audio.h"

typedef enum {
    kAudioPlayerStateReady = 0, 
    kAudioPlayerStatePlaying,
    kAudioPlayerStatePaused,
    kAudioPlayerStateUnconfigured
} AudioPlayerState;

@class AVPlayer;
@class AudioRouteChangeListener;

@interface AudioPlayer : UIResponder {
    AVPlayer *player;
}

+ (id)sharedInstance;

- (void)play;
- (void)playAudioAtIndex:(NSInteger) index;
- (void)playNextAudio;
- (void)playPreviousAudio;

- (void)resume;
- (void)pause;
- (void)stop;

- (void)setProgress:(float)progress;

- (void)processAudioEvent:(UIEventSubtype)type;

@property (nonatomic, copy) NSArray *audioList;

@property (nonatomic,readonly) AudioPlayerState state;
@property (nonatomic,readonly) NSInteger playingIndex;
@property (nonatomic,readonly) id<Audio> playingAudio;
@property (nonatomic,readonly) NSTimeInterval playingAudioTime;

@end
