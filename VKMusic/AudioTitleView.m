//
//  AudioTitleLabel.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/13/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioTitleView.h"
#import "FrameAccessor.h"

static const float kUpdatingInterval = 0.05;
static const float kDefaultMovingStep = 0.5;
static const float kDefaultPauseInteval = 3;

@implementation AudioTitleView

#pragma mark -
#pragma mark life cycle

- (void) awakeFromNib
{
    [self startTimer];
}

- (void) dealloc
{
    [self stopTimer];
}

#pragma mark -
#pragma mark setters

- (void) setAudioTitle:(NSString *) audioTitle;
{
    [self changeMovingDirection:kMovingDirectionLeft];
    [title setFrame:CGRectZero];
    [title setText:audioTitle];
    [title sizeToFit];
}

#pragma mark -
#pragma mark manage timer

- (void) startTimer
{
    if (timer == nil) {
        timer = [NSTimer timerWithTimeInterval:kUpdatingInterval
                                        target:self
                                      selector:@selector(updateContent)
                                      userInfo:nil
                                       repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void) stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void) updateContent
{
    float hiddenTitleLength = title.width - self.width;
    if (hiddenTitleLength > 0) {
        if (lockMovingForTimeInterval > 0) {
            lockMovingForTimeInterval -= kUpdatingInterval;
        }
        else {
            title.x += kDefaultMovingStep * ((movingDirection == kMovingDirectionLeft) ? -1 : 1);
            
            if (fabsf(title.x) >= hiddenTitleLength) {
                [self changeMovingDirection:kMovingDirectionRight];
            }
            else if (title.x >= 0) {
                [self changeMovingDirection:kMovingDirectionLeft];
            }
        }
    }
    else {
        title.origin = CGPointZero;
    }
}

- (void) changeMovingDirection:(MovingDirection) direction
{
    movingDirection = direction;
    lockMovingForTimeInterval = kDefaultPauseInteval;
}

@end
