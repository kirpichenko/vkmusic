//
//  Album.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/15/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "Album.h"

@implementation Album

- (void)dealloc
{
    [self setTitle:nil];
}

+ (ObjectMapping *)apiResponseMapping
{
    ObjectMapping *mapping = [[ObjectMapping alloc] initWithObjectClass:[Album class]];
    [mapping mapObjectProperty:@"ownerID" forResource:@"owner_id"];
    [mapping mapObjectProperty:@"albumID" forResource:@"album_id"];
    [mapping mapObjectProperties:@[@"title"]];
    return mapping;
}

@end
