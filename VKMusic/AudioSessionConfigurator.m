//
//  AudioSessionConfigurator.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/12/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioSessionConfigurator.h"

#import <AVFoundation/AVFoundation.h>

@implementation AudioSessionConfigurator

- (void)configureAudioSession
{
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error != nil) {
        NSLog(@"Set asudio session category error:%@",[error localizedDescription]);
    }    
}


@end
