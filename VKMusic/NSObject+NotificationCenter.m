//
//  NSObject+NotificationCenter.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/12/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSObject+NotificationCenter.h"

@implementation NSObject (NotificationCenter)

- (void) observeNotificationNamed:(NSString *) name withSelector:(SEL) selector
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:name object:nil];
}

- (void) stopObservingNotificationNamed:(NSString *) name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}

- (void) stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
