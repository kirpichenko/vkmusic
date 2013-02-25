//
//  OfflineAudio.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/8/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OfflineAudio.h"


@implementation OfflineAudio

@dynamic artist;
@dynamic audioID;
@dynamic lyricsID;
@dynamic duration;
@dynamic title;
@dynamic audioURL;

- (NSURL *) url
{
    return [NSURL fileURLWithPath:[self audioURL]];
}

@end
