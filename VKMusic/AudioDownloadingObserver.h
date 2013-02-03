//
//  AudioFileLoader.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EKDownloaderDelegate.h"
#import "AudioDownloadingDelegate.h"

@interface AudioDownloadingObserver : NSObject <EKDownloaderDelegate>

- (id) initWithDelegate:(id<AudioDownloadingDelegate>) delegate
                  audio:(OnlineAudio *) audio;

@end
