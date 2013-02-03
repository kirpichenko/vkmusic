//
//  AudioDownloadingDelegate.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OnlineAudio;

@protocol AudioDownloadingDelegate <NSObject>

@optional
- (void) audioFileLoaded:(OnlineAudio *) audio;
- (void) audioFile:(OnlineAudio *) audio loadingInProgress:(NSInteger) progress;
- (void) audioFile:(OnlineAudio *) audio loadingFailed:(NSError *) error;

@end
