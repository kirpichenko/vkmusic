//
//  SecondaryPlayerView.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 5/11/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TonarmDelegate
- (void)userChangedTonarmProgress:(float)progress;
@end

@class CADisplayLink;

@interface SecondaryPlayerView : UIView
{
    UISlider *volumeSlider;
    CADisplayLink *displayLink;
    
    IBOutlet UIImageView *rotatingLogoView;
    IBOutlet UIImageView *tonarmView;
    IBOutlet UIImageView *diskImageView;
    
    IBOutlet UIView *sliderBackgroundView;
}

@property (nonatomic,readonly) UISlider *volumeSlider;
@property (nonatomic,strong) AudioPlayer *player;

@property (nonatomic,weak) IBOutlet id<TonarmDelegate> tonarmDelegate;

@end
