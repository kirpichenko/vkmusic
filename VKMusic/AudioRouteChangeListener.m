//
//  AudioSessionConfigurator.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/12/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioRouteChangeListener.h"

#import <AVFoundation/AVFoundation.h>

static NSString *const kOutputDeviceKey = @"OutputDeviceDidChange_NewRoute";
static NSString *const kOutputDeviceHeadphone = @"Headphone";
static NSString *const kOutputDeviceSpeaker = @"Speaker";

@interface AudioRouteChangeListener ()
@property (nonatomic,strong) AudioPlayer *audioPlayer;
@end

@implementation AudioRouteChangeListener

#pragma mark - life cycle

- (id)initWithAudioPlayer:(AudioPlayer *)player
{
    if (self = [super init]) {
        [self setAudioPlayer:player];
        [self setAudioSessionActive:YES];
        [self setAudioSessionCategory:AVAudioSessionCategoryPlayback];
    }
    return self;
}

- (void)dealloc
{
    [self setAudioPlayer:nil];
    [self endRouteChangeListening];
}

#pragma mark - private methods

- (void)setAudioSessionCategory:(NSString *)categoryName
{
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:categoryName error:&error];

    if (error != nil) {
        NSLog(@"Set asudio session category error:%@",[error localizedDescription]);
    }
}

- (void)setAudioSessionActive:(BOOL)active
{
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    if (error != nil) {
        NSLog(@"Set asudio session activity error:%@",[error localizedDescription]);
    }
}

#pragma mark - public methods

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

#pragma mark - callbacks

void audioRouteChangeListenerCallback (void *inUserData, AudioSessionPropertyID inPropertyID,
                                       UInt32 inPropertyValueSize, const void *inPropertyValue)
{
    NSDictionary *dictionary = (__bridge NSDictionary *)(inPropertyValue);
    NSString *outputDevice = [dictionary objectForKey:kOutputDeviceKey];
    AudioPlayer *audioPlayer = [(__bridge AudioRouteChangeListener *)inPropertyValue audioPlayer];

//    if ([outputDevice isEqualToString:kOutputDeviceHeadphone]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:HeadphoneConnectedNotification
//                                                            object:nil];
//    }
    
    if ([outputDevice isEqualToString:kOutputDeviceSpeaker]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:HeadphoneDisconnectedNotification
//                                                            object:nil];
        [audioPlayer pause];
    }
}

@end
