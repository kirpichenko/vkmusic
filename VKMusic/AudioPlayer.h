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
    kAudioPlayerStatePlaing,
    kAudioPlayerStatePaused,
    kAudioPlayerStateUnconfigured
} AudioPlayerState;

@interface AudioPlayer : NSObject {
}

+ (id) sharedInstance;

- (void) play;
- (void) playAudioAtIndex:(NSInteger) index;
- (void) playNextAudio;
- (void) playPreviousAudio;

- (void) resume;
- (void) pause;
- (void) stop;

@property (nonatomic, readonly) AudioPlayerState state;
@property (nonatomic, copy) NSArray *audioList;
@property (nonatomic, readonly) NSInteger playingIndex;
@property (nonatomic, readonly) Audio *playingAudio;

@end
