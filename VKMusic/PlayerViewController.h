//
//  PlayerViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NGTabBarController;

@interface PlayerViewController : UIViewController
{
    __weak IBOutlet UIView *controlsView;
    __weak IBOutlet UIView *indicatorView;
    __weak IBOutlet UIView *contentView;
    
    NGTabBarController *tabBarController;
}

@end
