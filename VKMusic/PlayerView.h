//
//  PlayerView.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/13/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioProgressView;
@class AudioTitleView;

@interface PlayerView : UIView {
    __weak IBOutlet UIButton *playPauseButton;
    __weak IBOutlet AudioTitleView *audioTitle;
    __weak IBOutlet UILabel *audioCurrentTime;
    __weak IBOutlet AudioProgressView *progressView;
}

@property (nonatomic, strong) AudioPlayer *player;

@end
