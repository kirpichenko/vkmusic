//
//  ResponseParser.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "ResponseParser.h"
#import "MappingManager.h"

#import "OnlineAudio.h"
#import "Album.h"

typedef id(^ParseModelBlock)(NSDictionary *properties);

@implementation ResponseParser

- (NSArray *) parseAudioListFromResponse:(id) response
{
    Mapping *audioMapping = [[MappingManager sharedInstance] audioMapping];
    ParseModelBlock parsingBlock = ^(NSDictionary *properties) {
        OnlineAudio *audio = [[OnlineAudio alloc] init];
        [audio setUrl:[NSURL URLWithString:[properties objectForKey:@"url"]]];
        [audioMapping applyForObject:audio withResource:properties];
        return audio;
    };
    
    return [self parseArrayFromResponse:response objectParsing:parsingBlock];
}

- (NSArray *)parseAlbumsListFromResponse:(id)response
{
    Mapping *albumMapping = [[MappingManager sharedInstance] albumMapping];
    ParseModelBlock parsingBlock = ^(NSDictionary *properties) {
        Album *album = [[Album alloc] init];
        [albumMapping applyForObject:album withResource:properties];
        return album;
    };
    
    return [self parseArrayFromResponse:response objectParsing:parsingBlock];
}

#pragma mark -
#pragma mark helpers

- (NSArray *)parseArrayFromResponse:(id)response objectParsing:(id(^)(NSDictionary *))parse
{
    NSArray *responseList = [response objectForKey:@"response"];
    NSMutableArray *parsedList = [NSMutableArray arrayWithCapacity:[responseList count]];

    for (NSDictionary *properties in responseList) {
        if ([properties isKindOfClass:[NSDictionary class]]) {
            id object = parse(properties);
            [parsedList addObject:object];
        }
    }
    
    return parsedList;
}

    
    
@end
