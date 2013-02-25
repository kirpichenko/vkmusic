//
//  Lyrics.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "Lyrics.h"

@implementation Lyrics

- (void)dealloc
{
    [self setText:nil];
}

+ (ObjectMapping *)apiResponseMapping
{
    ObjectMapping *mapping = [[ObjectMapping alloc] initWithObjectClass:[Lyrics class]];
    [mapping mapObjectProperty:@"lyricsID" forResource:@"lyrics_id"];
    [mapping mapObjectProperties:@[@"text"]];
    return mapping;
}

@end
