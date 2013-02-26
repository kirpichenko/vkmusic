//
//  AudioViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioListViewController.h"

#import "AudioCell.h"

#import "UITableView+CellCreation.h"


@interface AudioListViewController () <UITableViewDelegate>
@end

@implementation AudioListViewController

@synthesize audioRecords;

#pragma mark -
#pragma mark life cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    EKKeyboardAvoidingScrollViewManager *manager = [EKKeyboardAvoidingScrollViewManager sharedInstance];
    [manager registerScrollViewForKeyboardAvoiding:audioList];
}

- (void) dealloc
{
    EKKeyboardAvoidingScrollViewManager *manager = [EKKeyboardAvoidingScrollViewManager sharedInstance];
    [manager unregisterScrollViewFromKeyboardAvoiding:audioList];
    
    [self setAudioRecords:nil];
}

#pragma mark -
#pragma mark instance methods

- (void) audioHaveBeenLoaded:(NSArray *) audio
{
    [self setAudioRecords:audio];
    [audioList reloadData];
}

- (void)audioLoadingFailed:(NSError *)error
{
    NSLog(@"audio loading failed %@",error);
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count");
    return [audioRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"create cell");
    id<Audio> audio = [audioRecords objectAtIndex:indexPath.row];
    
    AudioCell *cell = [tableView cellForClass:[AudioCell class]];
    [cell setAudio:audio];
    [cell setAudioCacheStatus:[self audioCacheStatus:audio]];    
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<Audio> audio = [audioRecords objectAtIndex:indexPath.row];

    AudioPlayer *player = [AudioPlayer sharedInstance];
    [player setAudioList:audioRecords];
    [player playAudioAtIndex:[audioRecords indexOfObject:audio]];
}

#pragma mark -
#pragma mark helpers

- (AudioCacheStatus)audioCacheStatus:(id<Audio>)audio
{
    OfflineAudioManager *manager = [OfflineAudioManager sharedInstance];
    if ([manager isAudioSaved:[audio audioID]]) {
        return kAudioCacheStatusSaved;
    }
    else {
        if ([manager isAudioLoading:[audio audioID]]) {
            return kAudioCacheStatusSaveInProgress;
        }
        return kAudioCacheStatusNotSaved;
    }
}

@end
