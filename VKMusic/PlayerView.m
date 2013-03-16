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
static const float kHorizontalOffset = 7.f;
static const NSTimeInterval kAnimationDuration = 0.5;
static const NSTimeInterval kProgressUnlockDelay = 0.5;

@interface PlayerView ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL progressLocked;
@end

@implementation PlayerView

#pragma mark -
#pragma mark life cycle

- (void) awakeFromNib
{
    [audioTitle setAudioTitle:nil];
    [audioCurrentTime setText:nil];
    
    [self startTimer];
}

- (void) dealloc
{
    [self stopTimer];
    [self setPlayer:nil];
}

#pragma mark -
#pragma mark instance methods

- (void)reset
{
    [audioCurrentTime setText:nil];
    [audioTitle setAudioTitle:nil];
    [progressSlider setValue:0];
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
    OnlineAudio *audio = (OnlineAudio *)[change objectForKey:@"new"];
    NSString *title = [NSString stringWithFormat:@"%@ - %@",[audio artist], [audio title]];
    [audioTitle setAudioTitle:title];
}

#pragma mark -
#pragma mark playing timer updates

- (void) startTimer
{
    if ([self timer] != nil) {
        [self stopTimer];
    }
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(updateTimeIndicators)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self setTimer:timer];
    
}

- (void) stopTimer
{
    [[self timer] invalidate];
    [self setTimer:nil];
}

- (void) updateTimeIndicators
{
    if ([[self player] playingAudio] == nil || [self progressLocked])
    {
        return;
    }
    
    NSTimeInterval elapsedTime = [[self player] currentTime];
    NSTimeInterval audioDuration = [[[self player] playingAudio] duration];

    [self updateTimeLabel:elapsedTime / audioDuration];
    
    if (![progressSlider isHighlighted]) {
        [progressSlider setValue:elapsedTime / audioDuration animated:NO];
    }
}

- (void)setProgress:(float)progress lock:(BOOL)lock
{
    [self updateTimeLabel:progress];
    if (lock) {
        [self setProgressLocked:lock];
    }
    else {
        [self performSelector:@selector(unlock) withObject:nil afterDelay:kProgressUnlockDelay];
    }
}

#pragma mark -
#pragma mark layout

- (void) layoutSubviews
{
    [audioCurrentTime sizeToFit];
    [audioCurrentTime setX:CGRectGetMaxX([progressSlider frame]) - audioCurrentTime.width];
    
    [audioTitle setWidth:audioCurrentTime.x - audioTitle.x - kHorizontalOffset];
}

#pragma mark -
#pragma mark helpers

- (void)updateTimeLabel:(double)progress
{
    NSTimeInterval audioDuration = [[[self player] playingAudio] duration];
    NSTimeInterval slideDuration = audioDuration * (1. - progress);
    
    NSString *remainingTimeString = [NSString stringWithTimeInterval:slideDuration];
    
    BOOL needLayout = [[audioCurrentTime text] length] != [remainingTimeString length];
    if (needLayout) {
        [self setNeedsLayout];
    }
    
    [audioCurrentTime setText:[NSString stringWithFormat:@"%@",remainingTimeString]];
}

- (void)unlock
{
    [self setProgressLocked:NO];
}

@end
