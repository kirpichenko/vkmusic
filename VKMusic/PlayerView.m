//
//  PlayerView.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/13/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PlayerView.h"
#import "AudioTitleView.h"

static NSString *kPlayingAudioKey = @"playingAudio";

@implementation PlayerView

#pragma mark -
#pragma mark life cycle

- (void) awakeFromNib
{
    [audioTitle setAudioTitle:nil];
    [audioCurrentTime setText:nil];
}

- (void) dealloc
{
    [self setPlayer:nil];
}

#pragma mark -
#pragma mark setters

- (void) setPlayer:(AudioPlayer *)player
{
    [_player removeObserver:self forKeyPath:kPlayingAudioKey];

    if (player) {
        _player = player;
        [_player addObserver:self
                  forKeyPath:kPlayingAudioKey
                     options:NSKeyValueObservingOptionNew
                     context:nil];
    }    
}


#pragma mark -
#pragma mark observing

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    Audio *audio = (Audio *)[change objectForKey:@"new"];
    NSString *title = [NSString stringWithFormat:@"%@ - %@",[audio artist], [audio title]];
    [audioTitle setAudioTitle:title];
}


@end
