//
//  ResponseParser.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "ResponseParser.h"
#import "MappingManager.h"

#import "Audio.h"

@implementation ResponseParser

- (NSArray *) parseAudioListFromResponse:(id) response
{
    NSArray *audioList = [response objectForKey:@"response"];
    NSMutableArray *parsedAudioList = [NSMutableArray arrayWithCapacity:[audioList count]];
    Mapping *audioMapping = [[MappingManager sharedInstance] audioMapping];
    for (NSDictionary *audioProperties in audioList) {
        Audio *audio = [[Audio alloc] init];
        [audio setUrl:[NSURL URLWithString:[audioProperties objectForKey:@"url"]]];
        [audioMapping applyForObject:audio withResource:audioProperties];
        [parsedAudioList addObject:audio];
    }
    return parsedAudioList;
}

@end
