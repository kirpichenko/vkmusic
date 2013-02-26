//
//  AudioFilteringViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioListViewController.h"

@interface AudioFilteringViewController : AudioListViewController
{
    __weak IBOutlet UITextField *searchField;
}

- (void)filterRecords:(NSString *)filter;

@property (nonatomic,strong) NSArray *audioRecordsFull;

@end
