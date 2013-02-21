//
//  AudioGetModel.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/11/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioGetApiRequest.h"
#import "MappingManager.h"

@implementation AudioGetApiRequest

#pragma mark -
#pragma marl instance methods

- (NSString *)apiQuery
{
    return [NSString stringWithFormat:@"uid=%d&count=%d&offset=%d&album_id=%d",
            [self userID],
            [self count],
            [self offset],
            [self albumID]];
}

- (ObjectMapping *)responseObjectsMapping
{
    return [[MappingManager sharedInstance] audioMapping];
}

@end
