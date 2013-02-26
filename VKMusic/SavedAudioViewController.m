//
//  SavedViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SavedAudioViewController.h"

#import "OfflineAudio.h"
#import "AudioCell.h"

#import "UITableView+CellCreation.h"

@interface SavedAudioViewController () <UITableViewDataSource,UITabBarDelegate>
@end

@implementation SavedAudioViewController

#pragma mark -
#pragma mark life cycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *audio = [[OfflineAudioManager sharedInstance] offlineAudioList];
    [self audioHaveBeenLoaded:audio];
}

@end
