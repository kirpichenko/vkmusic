//
//  UsersAudioViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/4/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "UsersAudioViewController.h"

#import "OnlineAudio.h"
#import "AudioCell.h"
#import "UITableView+CellCreation.h"

@interface UsersAudioViewController ()
    <UITableViewDataSource,
    UITableViewDelegate,
    AudioDownloaderDelegate,
    AudioCellDelegate>
@property (nonatomic, strong) NSArray *audioRecords;
@end

static const NSInteger kAudioCountPerRequest = 50;

@implementation UsersAudioViewController

#pragma mark -
#pragma mark life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self registerForNotificationNamed:kUserSignedIn selector:@selector(userSignedIn)];
        [self registerForNotificationNamed:kUserSignedOut selector:@selector(userSignedOut)];
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark load view

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[SettingsManager sharedInstance] isUserAuthorized] &&
        [[self audioRecords] count] == 0)
    {
        [self loadAudio];
    }
}

#pragma mark -
#pragma mark notifications

- (void) registerForNotificationNamed:(NSString *) name selector:(SEL) selector
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}

- (void) userSignedIn
{
    [self loadAudio];
}

- (void) userSignedOut
{
    NSLog(@"signed out");
}

#pragma mark -
#pragma mark load audio

- (void) loadAudio
{
    ApiRequestSender *sender = [ApiRequestSender sharedInstance];
    __weak UsersAudioViewController *selfController = self;
    
    [sender sendApiRequest:[self audioApiRequest]
                   success:^(id response){
                       NSMutableArray *audio = [NSMutableArray arrayWithArray:[self audioRecords]];
                       [audio addObjectsFromArray:response];
                       [selfController audioHaveBeenLoaded:audio];
                   }
                   failure:^(NSError *error) {
                       NSLog(@"fail = %@",error);
                   }];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioCell *cell = (AudioCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell setDelegate:self];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row + 1) == ([[self audioRecords] count]) &&
        (indexPath.row + 1) % kAudioCountPerRequest == 0)
    {
        [self loadAudio];
    }
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

- (AudioCell *)cellForAudio:(id<Audio>)audio
{
    NSIndexPath *indexPath = [self cellIndexPathForAudio:audio];
    if (indexPath != nil) {
        return (AudioCell *)[audioList cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSIndexPath *)cellIndexPathForAudio:(id<Audio>)audio
{
    NSInteger index = [[self filteredRecords] indexOfObject:audio];
    if (index != NSNotFound) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    }
    return nil;
}

#pragma mark -
#pragma mark requests

- (AudioGetApiRequest *)audioApiRequest
{
    ApiRequestManager *manager = [[ApiRequestManager alloc] init];

    Class ApiRequestClass = [AudioGetApiRequest class];
    AudioGetApiRequest *model = [manager apiRequestTemplateOfClass:ApiRequestClass];

    [model setUserID:[[SettingsManager sharedInstance] authorizedUserID]];
    [model setCount:kAudioCountPerRequest];
    [model setOffset:[[self audioRecords] count]];
    [model setAlbumID:[self albumID]];
    
    return model;
}


@end
