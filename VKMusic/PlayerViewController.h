//
//  PlayerViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuTabBarController;
@class PlayerView;

@interface PlayerViewController : UIViewController
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet PlayerView *playerView;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UITextView *lyricsTextView;
    
    MenuTabBarController *tabBarController;
}

- (id) initWithPlayer:(AudioPlayer *) player;

@end
