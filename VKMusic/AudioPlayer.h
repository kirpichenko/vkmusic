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

@interface AudioPlayer : NSObject {
    AVPlayer *player;
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

@property (nonatomic, readonly) AudioPlayerState state;
@property (nonatomic, copy) NSArray *audioList;
@property (nonatomic, readonly) NSInteger playingIndex;
@property (nonatomic, readonly) OnlineAudio *playingAudio;

@end
