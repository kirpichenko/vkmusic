//
//  AudioPlayer.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OnlineAudio.h"

typedef enum {
    kAudioPlayerStateReady = 0, 
    kAudioPlayerStatePlaying,
    kAudioPlayerStatePaused,
    kAudioPlayerStateUnconfigured
} AudioPlayerState;

@class AVPlayer;
@class AudioSessionConfigurator;

@interface AudioPlayer : UIResponder {
    AVPlayer *player;
    AudioSessionConfigurator *sessionConfigurator;
}

+ (id) sharedInstance;

- (void) play;
- (void) playAudioAtIndex:(NSInteger) index;
- (void) playNextAudio;
- (void) playPreviousAudio;

- (void) resume;
- (void) pause;
- (void) stop;

- (NSTimeInterval) currentTime;

- (void) processAudioEvent:(UIEventSubtype)type;

@property (nonatomic, readonly) AudioPlayerState state;
@property (nonatomic, copy) NSArray *audioList;
@property (nonatomic, readonly) NSInteger playingIndex;
@property (nonatomic, readonly) OnlineAudio *playingAudio;

@end
