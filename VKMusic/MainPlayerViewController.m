//
//  PlayerViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "MainPlayerViewController.h"
#import "MenuTabBarController.h"
#import "SecondaryPlayerViewController.h"

#import "PlayerView.h"
#import "MenuView.h"
#import "AudioPlayer.h"

#import "LyricsGetApiRequest.h"
#import "ApiRequestSender.h"

#import "NSObject+NotificationCenter.h"

static NSString *kPlayingAudioKey = @"playingAudio";
static const float kAnimationDuration = 1;

@interface MainPlayerViewController () <MenuTabBarControllerDelegate>
@property (nonatomic,strong) AudioPlayer *player;
@property (nonatomic,strong) UIView *visibleView;
@end

@implementation MainPlayerViewController

#pragma mark -
#pragma mark life cycle

- (id) initWithPlayer:(AudioPlayer *) player
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        tabBarController = [[MenuTabBarController alloc] initWithDelegate:self];
        secondaryController = [[SecondaryPlayerViewController alloc] initWithAudioPlayer:player];

        [self setPlayer:player];        
        [player addObserver:self
                 forKeyPath:kPlayingAudioKey
                    options:NSKeyValueObservingOptionNew
                    context:nil];
        
        [self observeNotificationNamed:kUserSignedOut withSelector:@selector(userSignedOut)];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [playerView setPlayer:[self player]];
    
    [menuView setContentView:[tabBarController view]];
    [menuView setTitle:[tabBarController selectedViewController].ng_tabBarItem.title];

    [self setVisibleView:menuView];
    [self addSwipeToPopController];
}

- (void)viewDidUnload
{
    playerView = nil;
    menuView = nil;
    
    [super viewDidUnload];
}

- (void) dealloc
{
    [[self player] removeObserver:self forKeyPath:kPlayingAudioKey];
    [self setPlayer:nil];
    [self setVisibleView:nil];
}

#pragma mark -
#pragma mark MenuTabBarControllerDelegate

- (void)tabBar:(MenuTabBarController *)tabBar didSelectController:(UIViewController *)controller
{
    [menuView setTitle:[controller.ng_tabBarItem title]];
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
#pragma mark load lyrics

- (LyricsGetApiRequest *)lyricsGetApiRequest
{
    LyricsGetApiRequest *apiRequest = [[LyricsGetApiRequest alloc] init];
    [apiRequest setLyricsID:[[[self player] playingAudio] lyricsID]];
    return apiRequest;
}

- (void)loadLyrics
{
    [[ApiRequestSender sharedInstance] sendApiRequest:[self lyricsGetApiRequest]
                                              success:^(id response) {
                                                  [self lyricsLoaded:response];
                                              }
                                              failure:^(NSError *error) {
                                                  NSLog(@"lyrics error %@",error);
                                              }];
}

- (void)lyricsLoaded:(Lyrics *)lyrics
{
//    [lyricsTextView setText:[lyrics text]];
}

#pragma mark -
#pragma mark observe audio change

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    if ([[_player playingAudio] lyricsID] != 0) {
        [self loadLyrics];
    }
}

#pragma mark -
#pragma mark notifications

- (void)userSignedOut
{
    [playerView reset];
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

- (IBAction)showHideMenu
{
    UIView *newVisibleView = ([self visibleView] == menuView) ? [secondaryController view] : menuView;
    UIView *contentView = [playerView contentView];
    
    [UIView transitionWithView:contentView
                      duration:kAnimationDuration
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [[self visibleView] removeFromSuperview];
                        [newVisibleView setFrame:[contentView bounds]];
                        [self setVisibleView:newVisibleView];
                        [contentView addSubview:newVisibleView];
                    }
                    completion:nil];
}

- (IBAction)progressChanged:(id)sender
{
    float progress = [(UISlider *)sender value];
    [playerView setProgress:progress lock:YES];
}

- (IBAction)progressSet:(id)sender
{
    float progress = [(UISlider *)sender value];
    [[self player] setProgress:progress];
    [playerView setProgress:progress lock:NO];
}

@end
