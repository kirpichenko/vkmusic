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

@interface SavedAudioViewController ()
@end

@implementation SavedAudioViewController

#pragma mark -
#pragma mark life cycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self clean];
    [self objectsHaveBeenLoaded:[self userAudio]];
}

- (NSArray *)userAudio
{
    User *user = [[SettingsManager sharedInstance] signedUser];
    return [[user audioList] allObjects];
}

@end
