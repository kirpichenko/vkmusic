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
    __weak IBOutlet UILabel *titleLable;
    __weak IBOutlet UIButton *playPauseButton;
    __weak IBOutlet AudioTitleView *audioTitle;
    __weak IBOutlet UISlider *progressSlider;
    __weak IBOutlet UITextView *lyricTextView;
    __weak IBOutlet UIView *contentView;
}

- (void)setLyricsHidden:(BOOL)hidden;
- (void)setProgress:(float)progress lock:(BOOL)lock;
- (void)reset;

@property (nonatomic, strong) AudioPlayer *player;
@property (nonatomic, readonly) BOOL lyricsDisplayed;

@end
