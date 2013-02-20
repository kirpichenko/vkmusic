//
//  PlayerViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PlayerViewController.h"
#import "MenuTabBarController.h"

#import "PlayerView.h"
#import "AudioPlayer.h"

@interface PlayerViewController () <MenuTabBarControllerDelegate>
@property (nonatomic, strong) AudioPlayer *player;
@end

@implementation PlayerViewController

#pragma mark -
#pragma mark life cycle

- (id) initWithPlayer:(AudioPlayer *) player
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        tabBarController = [[MenuTabBarController alloc] init];
        [tabBarController setMenuDelegate:self];
        [self setPlayer:player];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [playerView setPlayer:[self player]];    
    [titleLabel setText:[tabBarController selectedViewController].ng_tabBarItem.title];
    
    UIView *tabBarView = [tabBarController view];
    [contentView addSubview:tabBarView];
    [tabBarView setFrame:[contentView bounds]];
    [tabBarView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight |
                                     UIViewAutoresizingFlexibleWidth)];

    [self addSwipeToPopController];
}

- (void)viewDidUnload {
    titleLabel = nil;
    lyricsTextView = nil;
    contentView = nil;
    playerView = nil;
    
    [super viewDidUnload];
}

- (void) dealloc
{
    [self setPlayer:nil];
}

#pragma mark -
#pragma mark MenuTabBarControllerDelegate

- (void)tabBar:(MenuTabBarController *)tabBar didSelectController:(UIViewController *)controller
{
    [titleLabel setText:[controller.ng_tabBarItem title]];
}

#pragma mark -
#pragma mark swipe callback

- (void)addSwipeToPopController
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(userSwiped)];
    [[self view] addGestureRecognizer:swipe];
}

- (void)userSwiped
{
    UINavigationController *navigationController = (UINavigationController *)
    [tabBarController selectedViewController];    
    [navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark actions

- (IBAction)playPause
{
    AudioPlayer *player = [self player];
    if ([player state] == kAudioPlayerStatePaused) {
        [player resume];
    }
    else if ([player state] == kAudioPlayerStatePlaying) {
        [player pause];
    }
}

- (IBAction)playNextAudio
{
    [[self player] playNextAudio];
}

- (IBAction)playPreviousAudio
{
    [[self player] playPreviousAudio];
}

- (IBAction)showHideLyricsView
{
    [playerView setLyricsHidden:[playerView lyricsDisplayed]];
}

@end
