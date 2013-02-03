//
//  AudioFilesManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AudioDownloadingDelegate.h"

#import "OnlineAudio.h"
#import "OfflineAudio.h"

@class EKFilesOnDiskCache;
@class EKFilesManager;

@interface OfflineAudioManager : NSObject {
    EKFilesOnDiskCache *filesCache;
    NSMutableArray *downloaders;
}

+ (id) sharedInstance;

- (void) saveAudio:(OnlineAudio *) audio;
- (void) saveAudio:(OnlineAudio *) audio delegate:(id<AudioDownloadingDelegate>) delegate;

- (void) deleteAudio:(OfflineAudio *) audio;

- (NSArray *) offlineAudioList;
- (NSArray *) downloadingAudioList;

@end
