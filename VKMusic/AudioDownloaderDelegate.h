//
//  AudioDownloadingDelegate.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OnlineAudio;

@protocol AudioDownloaderDelegate <NSObject>
@optional
- (void) audioFile:(OnlineAudio *) audio saved:(NSData *) audioData;
- (void) audioFile:(OnlineAudio *) audio loadingInProgress:(float) progress;
- (void) audioFile:(OnlineAudio *) audio loadingFailed:(NSError *) error;
@end
