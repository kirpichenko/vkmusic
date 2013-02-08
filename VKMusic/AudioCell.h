//
//  AudioCell.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Audio.h"

@protocol AudioCellDelegate <NSObject>
- (void) saveAudio:(id<Audio>) audio;
@end

@interface AudioCell : UITableViewCell
{
    __weak IBOutlet UILabel *artist;
    __weak IBOutlet UILabel *title;
    __weak IBOutlet UILabel *time;
    __weak IBOutlet UIButton *saveButton;
}

@property (nonatomic,strong) id<Audio> audio;
@property (nonatomic,weak) id<AudioCellDelegate> delegate;

@end
