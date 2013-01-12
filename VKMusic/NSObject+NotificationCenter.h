//
//  NSObject+NotificationCenter.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/12/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NotificationCenter)

- (void) observeNotificationNamed:(NSString *) name withSelector:(SEL) selector;
- (void) stopObservingNotificationNamed:(NSString *) name;
- (void) stopObserving;

@end
