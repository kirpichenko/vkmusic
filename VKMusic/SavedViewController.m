//
//  SavedViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SavedViewController.h"

#import "OfflineAudio.h"
#import "AudioCell.h"

#import "UITableView+CellCreation.h"

@interface SavedViewController () <UITableViewDataSource,UITabBarDelegate>
@property (nonatomic,strong,readwrite) NSArray *audioRecords;
@end

@implementation SavedViewController

#pragma mark -
#pragma mark life cycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *audio = [[OfflineAudioManager sharedInstance] offlineAudioList];
    [self audioHaveBeenLoaded:audio];
}

@end
