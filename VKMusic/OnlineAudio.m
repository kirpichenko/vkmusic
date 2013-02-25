//
//  Audio.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OnlineAudio.h"

@implementation OnlineAudio

#pragma mark -
#pragma mark life cycle

- (void)dealloc
{
    [self setArtist:nil];
    [self setTitle:nil];
    [self setUrl:nil];
}

#pragma mark -
#pragma mark set values

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"url"]) {
        [self setUrl:[NSURL URLWithString:value]];
    }
    else {
        [super setValue:value forKey:key];
    }
}

#pragma mark -
#pragma mark ApiModel method

+ (ObjectMapping *)apiResponseMapping
{
    ObjectMapping *mapping = [[ObjectMapping alloc] initWithObjectClass:[OnlineAudio class]];
    [mapping mapObjectProperties:@[@"artist",@"duration",@"title",@"url"]];
    [mapping mapObjectProperty:@"audioID" forResource:@"aid"];
    [mapping mapObjectProperty:@"lyricsID" forResource:@"lyrics_id"];
    [mapping mapObjectProperty:@"ownerID" forResource:@"owner_id"];
    return mapping;
}

@end
