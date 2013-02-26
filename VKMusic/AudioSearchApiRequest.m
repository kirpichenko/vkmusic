//
//  AudioSearchApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioSearchApiRequest.h"

@implementation AudioSearchApiRequest

#pragma mark -
#pragma mark life cycle

- (id)init
{
    if (self = [super init]) {
        [self setApiPath:kAudioSearchApiPath];
    }
    return self;
}

- (void)dealloc
{
    [self setQuery:nil];
}

#pragma mark -
#pragma marl instance methods

- (NSString *)apiQuery
{
    return [NSString stringWithFormat:@"q=%@&count=%d&offset=%d&auto_complete=%d",
            [self query],[self count],[self offset],[self autoComplete]];
}

- (ObjectMapping *)responseObjectsMapping
{
    return [OnlineAudio apiResponseMapping];
}

@end
