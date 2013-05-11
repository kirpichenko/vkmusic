//
//  SecondaryPlayerViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/16/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SecondaryPlayerViewController.h"
#import "SecondaryPlayerView.h"

@interface SecondaryPlayerViewController () <TonarmDelegate>
@property (nonatomic,strong) AudioPlayer *audioPlayer;
@end

@implementation SecondaryPlayerViewController

#pragma mark - life cycle

- (id)initWithAudioPlayer:(AudioPlayer *)audioPlayer
{
    if (self = [super init]) {
        [self setAudioPlayer:audioPlayer];
    }
    return self;
}

- (void)dealloc
{
    [self setAudioPlayer:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [playerView setPlayer:[self audioPlayer]];
}

- (void)viewDidUnload
{
    playerView = nil;

    [super viewDidUnload];
}

#pragma mark - tonarm delegate

- (void)userChangedTonarmProgress:(float)progress
{
    [[self audioPlayer] setProgress:progress];    
}

@end
