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
    __weak IBOutlet UILabel *audioCurrentTime;
    __weak IBOutlet UIButton *playPauseButton;
    __weak IBOutlet AudioTitleView *audioTitle;
    __weak IBOutlet UISlider *progressSlider;
    __weak IBOutlet UIView *contentView;
}

- (void)setProgress:(float)progress lock:(BOOL)lock;
- (void)reset;

@property (nonatomic,strong) AudioPlayer *player;
@property (nonatomic,readonly) UIView *contentView;

@end
