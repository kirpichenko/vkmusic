//
//  AudioViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioListViewController.h"

#import "UITableView+CellCreation.h"
//#import "UIScrollView+EKKeyboardAvoiding.h"

@interface AudioListViewController () <UITableViewDelegate,AudioDownloaderDelegate>
@property (nonatomic,strong) NSArray *objects;
@end

@implementation AudioListViewController

@synthesize objects;

#pragma mark -
#pragma mark life cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [objectsList setKeyboardAvoidingEnabled:YES];
}

#pragma mark -
#pragma mark template methods

- (BasePaginatedApiRequest *)objectsApiRequest
{
    return [self audioApiRequest];
}

#pragma mark -
#pragma mark instance methods

- (BasePaginatedApiRequest *)audioApiRequest
{
    [NSException raise:@"Exception" format:@"Implement audioApiRequest method in subclasses"];
    return nil;
}

- (void)loadAudio
{
    [self loadObjects];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<Audio> audio = [objects objectAtIndex:indexPath.row];
    
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
    
    id<Audio> audio = [objects objectAtIndex:indexPath.row];

    AudioPlayer *player = [AudioPlayer sharedInstance];
    [player setAudioList:objects];
    [player playAudioAtIndex:[objects indexOfObject:audio]];
}

#pragma mark -
#pragma mark AudioLoaderDelegate

- (void) saveAudio:(OnlineAudio *) audio
{
    OfflineAudioManager *manager = [OfflineAudioManager sharedInstance];
    if (![manager isAudioSaved:[audio audioID]]) {
        [manager loadAudio:audio delegate:self];
    }
}

- (void) audioFile:(OnlineAudio *) audio saved:(NSData *) audioData
{
    AudioCell *cell = [self cellForAudio:audio];
    [cell setAudioCacheStatus:kAudioCacheStatusSaved];
}

- (void) audioFile:(OnlineAudio *) audio loadingInProgress:(float) progress
{
    AudioCell *cell = [self cellForAudio:audio];
    [cell setProgress:progress * 100];
}

- (void) audioFile:(OnlineAudio *) audio loadingFailed:(NSError *) error
{
    AudioCell *cell = [self cellForAudio:audio];
    [cell setAudioCacheStatus:kAudioCacheStatusNotSaved];
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

- (AudioCell *)cellForAudio:(id<Audio>)audio
{
    NSIndexPath *indexPath = [self cellIndexPathForAudio:audio];
    if (indexPath != nil) {
        return (AudioCell *)[objectsList cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSIndexPath *)cellIndexPathForAudio:(id<Audio>)audio
{
    NSInteger index = [objects indexOfObject:audio];
    if (index != NSNotFound) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    }
    return nil;
}


@end
