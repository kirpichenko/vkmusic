//
//  MenuTabBarController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/20/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NGTabBarController.h"

@class MenuTabBarController;

@protocol MenuTabBarControllerDelegate <NSObject>
- (void)tabBar:(MenuTabBarController *)tabBar didSelectController:(UIViewController *)controller;
@end

@interface MenuTabBarController : NGTabBarController

- (id)initWithDelegate:(id<MenuTabBarControllerDelegate>)delegate;

@property (nonatomic,assign) id<MenuTabBarControllerDelegate>menuDelegate;

@end
