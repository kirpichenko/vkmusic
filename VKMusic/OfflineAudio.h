//
//  OfflineAudio.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Audio.h"

@class CachedAudio;

@interface OfflineAudio : NSObject <Audio>

- (id) initWithCachedAudio:(CachedAudio *) cachedAudio;

@end
