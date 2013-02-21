//
//  AudioSearchApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioSearchApiRequest.h"
#import "MappingManager.h"

@implementation AudioSearchApiRequest

#pragma mark -
#pragma mark life cycle

- (void)dealloc
{
    [self setQuery:nil];
}

#pragma mark -
#pragma marl instance methods

- (NSString *)apiQuery
{
    return [NSString stringWithFormat:@"q=%@&count=%d&offset=%d",
            [self query],
            [self count],
            [self offset]];
}

- (ObjectMapping *)responseObjectsMapping
{
    return [[MappingManager sharedInstance] audioMapping];
}

@end
