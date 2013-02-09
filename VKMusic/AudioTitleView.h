//
//  AudioTitleLabel.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/13/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kMovingDirectionLeft = 0,
    kMovingDirectionRight
} MovingDirection;

@interface AudioTitleView : UIView {
    __weak IBOutlet UILabel *title;

    NSTimer *timer;
    
    MovingDirection movingDirection;
    float lockMovingForTimeInterval;
}

- (void) setAudioTitle:(NSString *) audioTitle;

@end
