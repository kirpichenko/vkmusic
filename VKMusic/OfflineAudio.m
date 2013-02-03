//
//  OfflineAudio.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OfflineAudio.h"
#import "CachedAudio.h"

@interface OfflineAudio ()
@property (nonatomic, weak) CachedAudio *cachedAudio;
@end

@implementation OfflineAudio

- (id) initWithCachedAudio:(CachedAudio *) cachedAudio
{
    if (self = [super init]) {
        [self setCachedAudio:cachedAudio];
    }
    return self;
}

- (NSInteger) audioID
{
    return [[[self cachedAudio] audioID] integerValue];
}

- (NSString *) artist
{
    return [[self cachedAudio] artist];
}

- (NSString *) title
{
    return [[self cachedAudio] title];
}

- (NSTimeInterval) duration
{
    return [[[self cachedAudio] duration] doubleValue];
}

- (NSURL *) url
{
    return [NSURL URLWithString:[[self cachedAudio] url]];
}


@end
