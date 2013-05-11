//
//  PlayerView.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/13/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PlayerView.h"
#import "AudioTitleView.h"
#import "AudioProgressView.h"

#import "NSString+TimeFormatting.h"

static NSString *kPlayingAudioKey = @"playingAudio";
static NSString *kPlayingAudioTimeKey = @"playingAudioTime";

static const float kHorizontalOffset = 7.f;
static const NSTimeInterval kProgressUnlockDelay = 0.5;

@interface PlayerView ()
@property (nonatomic, assign) BOOL progressLocked;
@end

@implementation PlayerView

@synthesize contentView;

#pragma mark -
#pragma mark life cycle

- (void)awakeFromNib
{
    [audioTitle setAudioTitle:nil];
    [audioCurrentTime setText:nil];
}

- (void)dealloc
{
    [self setPlayer:nil];
}

#pragma mark -
#pragma mark instance methods

- (void)setProgress:(float)progress lock:(BOOL)lock
{
    [self updateTimeLabel:[[[self player] playingAudio] duration] * (1 - progress)];
    
    if (lock) {
        [self setProgressLocked:lock];
    }
    else {
        [self performSelector:@selector(unlock) withObject:nil afterDelay:kProgressUnlockDelay];
    }
}

- (void)reset
{
    [audioCurrentTime setText:nil];
    [audioTitle setAudioTitle:nil];
    [progressSlider setValue:0];
}

#pragma mark -
#pragma mark setters

- (void)setPlayer:(AudioPlayer *)player
{
    if (_player != player) {
        [_player removeObserver:self forKeyPath:kPlayingAudioKey];
        [_player removeObserver:self forKeyPath:kPlayingAudioTimeKey];
        
        _player = player;

        [_player addObserver:self forKeyPath:kPlayingAudioKey options:NSKeyValueObservingOptionNew
                     context:nil];
        [_player addObserver:self forKeyPath:kPlayingAudioTimeKey options:NSKeyValueObservingOptionNew
                     context:nil];
    }    
}


#pragma mark - observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kPlayingAudioKey]) {
        [self updatePlayingAudioTitle];
    }

    [self updatePlayingAudioTime];
}

- (void)updatePlayingAudioTitle
{
    id<Audio> audio = [[self player] playingAudio];
    NSString *title = [NSString stringWithFormat:@"%@ - %@",[audio artist], [audio title]];
    
    [audioTitle setAudioTitle:title];
}

- (void)updatePlayingAudioTime
{
    if ([[self player] playingAudio] == nil || [self progressLocked] ||
        [progressSlider isHighlighted])
    {
        return;
    }
    
    NSTimeInterval elapsedTime = [[self player] playingAudioTime];
    NSTimeInterval audioDuration = [[[self player] playingAudio] duration];
    NSTimeInterval remainingTime = audioDuration - elapsedTime;
    
    [self updateTimeLabel:remainingTime];
    [progressSlider setValue:elapsedTime / audioDuration animated:NO];
}

#pragma mark - layout

- (void) layoutSubviews
{
    [audioCurrentTime sizeToFit];
    [audioCurrentTime setX:CGRectGetMaxX([progressSlider frame]) - audioCurrentTime.width];
    
    [audioTitle setWidth:audioCurrentTime.x - audioTitle.x - kHorizontalOffset];
}

#pragma mark - helpers

- (void)updateTimeLabel:(NSTimeInterval)remainingTime
{
    if (remainingTime < 0) {
        return;
    }
    
    NSString *remainingTimeString = [NSString stringWithTimeInterval:remainingTime];

    BOOL needLayout = [[audioCurrentTime text] length] != [remainingTimeString length];
    [audioCurrentTime setText:remainingTimeString];
    
    if (needLayout) {
        [self setNeedsLayout];
    }
}

- (void)unlock
{
    [self setProgressLocked:NO];
}

@end
