//
//  MenuTabBarController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/20/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "MenuTabBarController.h"

#import "UsersAudioViewController.h"
#import "PlaylistsViewController.h"
#import "SavedViewController.h"
#import "SearchViewController.h"
#import "SettingsViewController.h"

@interface MenuTabBarController () <NGTabBarControllerDelegate>

@end

@implementation MenuTabBarController 

- (id)init
{
    if (self = [super initWithDelegate:self]) {
        NSArray *controllers = @[
            [self pageOfClass:[UsersAudioViewController class] itemTitle:@"Аудиозаписи" image:nil],
            [self pageOfClass:[PlaylistsViewController class] itemTitle:@"Альбомы" image:nil],
            [self pageOfClass:[SavedViewController class] itemTitle:@"Сохраненные" image:nil],
            [self pageOfClass:[SearchViewController class] itemTitle:@"Поиск" image:nil],
            [self pageOfClass:[SettingsViewController class] itemTitle:@"Настройки" image:nil]
        ];
        [self setViewControllers:controllers];
    }
    return self;
}

#pragma mark -
#pragma mark helpers

- (UIViewController *)pageOfClass:(Class)ControllerClass
                        itemTitle:(NSString *)title
                            image:(UIImage *)image
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

- (void)tabBarController:(NGTabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
                 atIndex:(NSUInteger)index
{
    if ([[self menuDelegate] respondsToSelector:@selector(tabBar:didSelectController:)]) {
        [[self menuDelegate] tabBar:self didSelectController:viewController];
    }
}

- (void)verticalTabBarController:(NGTabBarController *)tabBarController
         didSelectViewController:(UIViewController *)viewController
                         atIndex:(NSInteger)index
{
    NSLog(@"just fixes bug when delegate method isn't called");
}

@end
