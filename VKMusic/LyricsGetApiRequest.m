//
//  LyricsGetApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "LyricsGetApiRequest.h"

@implementation LyricsGetApiRequest

#pragma mark -
#pragma mark lyfe cycle

- (id)init
{
    if (self = [super init]) {
        [self setApiPath:kLyricsGetApiPath];
    }
    return self;
}

#pragma mark -
#pragma marl instance methods

- (NSString *)apiQuery
{
    return [NSString stringWithFormat:@"lyrics_id=%d",[self lyricsID]];
}

- (ObjectMapping *)responseObjectsMapping
{
    return [Lyrics apiResponseMapping];
}

@end
