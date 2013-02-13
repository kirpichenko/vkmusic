//
//  AudioSessionConfigurator.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/12/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const HeadphoneConnectedNotification = @"HeadphoneConnected";
static NSString *const HeadphoneDisconnectedNotification = @"HeadphoneDisconected";

@interface AudioSessionConfigurator : NSObject

- (void)setAudioSessionCategory:(NSString *)categoryName;

- (void)beginRouteChangeListening;
- (void)endRouteChangeListening;

@end
