//
//  NetworkActivityManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/10/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkActivityManager : NSObject
{
    NSInteger displayingCounter;
}

+ (id)sharedInstance;

- (void)showNetworkActivityIndicator;
- (void)stopNetworkActivityIndicator;

@end
