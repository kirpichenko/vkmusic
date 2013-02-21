//
//  AlbumsGetApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/14/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AlbumsGetApiRequest.h"
#import "MappingManager.h"

@implementation AlbumsGetApiRequest

#pragma mark -
#pragma marl instance methods

- (NSString *)apiQuery
{
    return [NSString stringWithFormat:@"uid=%d&count=%d&offset=%d",
            [self userID],
            [self count],
            [self offset]];
}

- (ObjectMapping *)responseObjectsMapping
{
    return [[MappingManager sharedInstance] albumMapping];
}

@end
