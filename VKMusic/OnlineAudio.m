//
//  Audio.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OnlineAudio.h"

@implementation OnlineAudio

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"url"]) {
        [self setUrl:[NSURL URLWithString:value]];
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
