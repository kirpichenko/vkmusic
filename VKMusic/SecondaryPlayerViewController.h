//
//  SecondaryPlayerViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/16/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioPlayer;
@class SecondaryPlayerView;

@interface SecondaryPlayerViewController : UIViewController
{
    IBOutlet SecondaryPlayerView *playerView;
}

- (id)initWithAudioPlayer:(AudioPlayer *)audioPlayer;

@end
