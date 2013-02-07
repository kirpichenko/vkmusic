//
//  AudioFileLoader.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EKFileDownloaderDelegate.h"
#import "AudioDownloaderDelegate.h"

@interface AudioDownloaderAdapter : NSObject <EKFileDownloaderDelegate>

- (id) initWithOnlineAudio:(OnlineAudio *) audio
                  delegate:(id<AudioDownloaderDelegate>) delegate;

@property (nonatomic,retain,readonly) id<AudioDownloaderDelegate> delegate;
@property (nonatomic,retain,readonly) OnlineAudio *audio;

@end
