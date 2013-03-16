//
//  PlayerViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuTabBarController;
@class SecondaryPlayerViewController;
@class PlayerView;
@class MenuView;

@interface MainPlayerViewController : UIViewController
{
    __weak IBOutlet PlayerView *playerView;
    __strong IBOutlet MenuView *menuView;
    
    MenuTabBarController *tabBarController;
    SecondaryPlayerViewController *secondaryController;
}

- (id) initWithPlayer:(AudioPlayer *) player;

@end
