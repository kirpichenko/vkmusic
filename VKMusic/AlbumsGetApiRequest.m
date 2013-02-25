//
//  AlbumsGetApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/14/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AlbumsGetApiRequest.h"

@implementation AlbumsGetApiRequest

- (id)init
{
    if (self = [super init]) {
        [self setApiPath:kAlbumsGetApiPath];
    }
    return self;
}

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
    return [Album apiResponseMapping];
}

@end
