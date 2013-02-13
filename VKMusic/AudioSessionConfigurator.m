//
//  AudioSessionConfigurator.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/12/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioSessionConfigurator.h"

#import <AVFoundation/AVFoundation.h>

static NSString *const kOutputDeviceKey = @"OutputDeviceDidChange_NewRoute";
static NSString *const kOutputDeviceHeadphone = @"Headphone";
static NSString *const kOutputDeviceSpeaker = @"Speaker";

@implementation AudioSessionConfigurator

#pragma mark -
#pragma mark instance methods

- (void)setAudioSessionCategory:(NSString *)categoryName
{
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:categoryName error:&error];
    if (error != nil) {
        NSLog(@"Set asudio session category error:%@",[error localizedDescription]);
    }    
}

- (void)beginRouteChangeListening
{
    AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange,
                                    audioRouteChangeListenerCallback,
                                    (__bridge void *)self);
}

- (void)endRouteChangeListening
{
    AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_AudioRouteChange,
												   audioRouteChangeListenerCallback,
												   (__bridge void *)self);
}

#pragma mark -
#pragma mark callbacks

void audioRouteChangeListenerCallback (void *inUserData, AudioSessionPropertyID inPropertyID,
                                       UInt32 inPropertyValueSize, const void *inPropertyValue)
{
    NSDictionary *dictionary = (__bridge NSDictionary *)(inPropertyValue);
    NSString *outputDevice = [dictionary objectForKey:kOutputDeviceKey];

    if ([outputDevice isEqualToString:kOutputDeviceHeadphone]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HeadphoneConnectedNotification
                                                            object:nil];
    }
    
    if ([outputDevice isEqualToString:kOutputDeviceSpeaker]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HeadphoneDisconnectedNotification
                                                            object:nil];
    }
}

@end
