//
//  PlayerViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PlayerViewController.h"

#import "UsersAudioViewController.h"
#import "PlaylistsViewController.h"
#import "SavedViewController.h"
#import "SearchViewController.h"
#import "SettingsViewController.h"

#import "PlayerView.h"
#import "AudioPlayer.h"

#import <NGTabBarController/NGTabBarController.h>

@interface PlayerViewController () <NGTabBarControllerDelegate>
@property (nonatomic, strong) AudioPlayer *player;
@end

@implementation PlayerViewController

#pragma mark -
#pragma mark life cycle

- (id) initWithPlayer:(AudioPlayer *) player
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        NSArray *controllers = @[
            [self controllerOfClass:[UsersAudioViewController class] itemTitle:@"Аудиозаписи" image:nil],
            [self controllerOfClass:[PlaylistsViewController class] itemTitle:@"Плейлисты" image:nil],
            [self controllerOfClass:[SavedViewController class] itemTitle:@"Сохраненные" image:nil],
            [self controllerOfClass:[SearchViewController class] itemTitle:@"Поиск" image:nil],
            [self controllerOfClass:[SettingsViewController class] itemTitle:@"Настрjqrb" image:nil],
        ];
        
        tabBarController = [[NGTabBarController alloc] initWithDelegate:self];
        [tabBarController setViewControllers:controllers];

        [self setPlayer:player];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [playerView setPlayer:[self player]];
    [contentView addSubview:[tabBarController view]];
    [[tabBarController view] setFrame:[contentView bounds]];
    [[tabBarController view] setAutoresizingMask:(UIViewAutoresizingFlexibleHeight |
                                                  UIViewAutoresizingFlexibleWidth)];
}

- (void) dealloc
{
    [self setPlayer:nil];
}

#pragma mark -
#pragma mark helpers

- (UIViewController *) controllerOfClass:(Class) ControllerClass
                               itemTitle:(NSString *) title
                                   image:(UIImage *) image
{
    UIViewController *controller = [[ControllerClass alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]
                                          initWithRootViewController:controller];
    [navigation setNavigationBarHidden:YES];
    navigation.ng_tabBarItem = [NGTabBarItem itemWithTitle:title image:image];
    return navigation;
}

#pragma mark -
#pragma mark NGTabBarControllerDelegate

- (CGSize)tabBarController:(NGTabBarController *)tabBarController
sizeOfItemForViewController:(UIViewController *)viewController
                   atIndex:(NSUInteger)index
                  position:(NGTabBarPosition)position
{
    return CGSizeMake(45, 45);
}

#pragma mark -
#pragma mark actions

- (IBAction) playPause
{
    AudioPlayer *player = [self player];
    if ([player state] == kAudioPlayerStatePaused) {
        [player resume];
    }
    else if ([player state] == kAudioPlayerStatePlaying) {
        [player pause];
    }
}

- (IBAction) playNextAudio
{
    [[self player] playNextAudio];
}

- (IBAction) playPreviousAudio
{
    [[self player] playPreviousAudio];
}

@end
