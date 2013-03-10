//
//  AudioViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PaginationViewController.h"
#import "AudioCell.h"

@interface AudioListViewController : PaginationViewController
    <UITableViewDataSource,
    AudioCellDelegate>

- (BasePaginatedApiRequest *)audioApiRequest;
- (void)loadAudio;

@end
