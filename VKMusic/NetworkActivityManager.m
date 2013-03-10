//
//  NetworkActivityManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/10/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NetworkActivityManager.h"

@implementation NetworkActivityManager

+ (id)sharedInstance
{
    static NetworkActivityManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkActivityManager alloc] init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init])
    {
        displayingCounter = 0;
    }
    return self;
}

- (void)showNetworkActivityIndicator
{
    if (displayingCounter == 0)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    displayingCounter += 1;
    
}

- (void)stopNetworkActivityIndicator
{
    displayingCounter -= 1;
    if (displayingCounter == 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

@end
