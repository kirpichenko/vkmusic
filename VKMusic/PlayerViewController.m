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

#import "AudioPlayer.h"

#import <NGTabBarController/NGTabBarController.h>

@interface PlayerViewController () <NGTabBarControllerDelegate>

@end

@implementation PlayerViewController

#pragma mark -
#pragma mark life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSArray *controllers = @[
            [self controllerOfClass:[UsersAudioViewController class] itemTitle:@"Аудиозаписи" image:nil],
            [self controllerOfClass:[PlaylistsViewController class] itemTitle:@"Плейлисты" image:nil],
            [self controllerOfClass:[SavedViewController class] itemTitle:@"Сохраненные" image:nil],
            [self controllerOfClass:[SearchViewController class] itemTitle:@"Поиск" image:nil],
            [self controllerOfClass:[SettingsViewController class] itemTitle:@"Настрjqrb" image:nil],
        ];
        
        tabBarController = [[NGTabBarController alloc] initWithDelegate:self];
        [tabBarController setViewControllers:controllers];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [contentView addSubview:[tabBarController view]];
    [[tabBarController view] setFrame:[contentView bounds]];
    [[tabBarController view] setAutoresizingMask:(UIViewAutoresizingFlexibleHeight |
                                                  UIViewAutoresizingFlexibleWidth)];
}

#pragma mark -
#pragma mark helpers

- (UIViewController *) controllerOfClass:(Class) ControllerClass
                               itemTitle:(NSString *) title
                                   image:(UIImage *) image
{
    UIViewController *controller = [[ControllerClass alloc] init];
    controller.ng_tabBarItem = [NGTabBarItem itemWithTitle:title image:image];
    return controller;
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
    
}

- (IBAction) playNextAudio
{
    
}

- (IBAction) playPreviousAudio
{
    
}

@end
