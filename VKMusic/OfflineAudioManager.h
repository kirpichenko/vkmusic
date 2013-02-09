//
//  AudioFilesManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AudioDownloaderDelegate.h"

#import "OnlineAudio.h"
#import "OfflineAudio.h"

@class EKFileOnDiskCache;
@class EKFileManager;

@interface OfflineAudioManager : NSObject {
    EKFileOnDiskCache *fileCache;
    EKFileManager *fileManager;
}

+ (id) sharedInstance;

- (void) loadAudio:(OnlineAudio *) audio;
- (void) loadAudio:(OnlineAudio *) audio delegate:(id<AudioDownloaderDelegate>) delegate;

- (NSArray *) offlineAudioList;
- (NSArray *) offlineAudioListWithFilter:(NSString *) filter;

@end
