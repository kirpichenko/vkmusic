//
//  AudioCell.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioCell.h"
#import "NSString+TimeFormatting.h"

static const float kHorizontalOffset = 8;

@implementation AudioCell

- (void) setAudio:(OnlineAudio *)audio
{
    if (_audio != audio) {
        _audio = audio;
        [self updateAudioInfo];
    }
}

- (void) updateAudioInfo
{
    [artist setText:[_audio artist]];
    [title setText:[_audio title]];

    [time setText:[NSString stringWithTimeInterval:[_audio duration]]];
    [time sizeToFit];
    
    [self layoutSubviews];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [time setX:CGRectGetMaxX([saveButton frame]) - time.width];
    [artist setWidth:time.x - artist.x - kHorizontalOffset];
}

#pragma mark -
#pragma mark actions

- (IBAction)saveAudio
{
    [[self delegate] saveAudio:[self audio]];
}

@end
