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
    RequestSender *sender = [RequestSender sharedInstance];
    AudioGetModel *model = [self nextRequestModel];

    __weak UsersAudioViewController *selfController = self;
    [sender sendAudioGetRequest:model
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
    [self reloadCellForAudio:audio];
    NSLog(@"loaded");
}

- (void) audioFile:(OnlineAudio *) audio loadingInProgress:(float) progress
{
    NSIndexPath *indexPath = [self cellIndexPathForAudio:audio];
    if (indexPath != nil) {
        AudioCell *cell = (AudioCell *)[audioList cellForRowAtIndexPath:indexPath];
        [cell setProgress:progress * 100];
    }
    NSLog(@"progress = %f",progress);
}

- (void) audioFile:(OnlineAudio *) audio loadingFailed:(NSError *) error
{
    [self reloadCellForAudio:audio];
    NSLog(@"error = %@",[error localizedDescription]);
}

#pragma mark -
#pragma mark helpers

- (void)reloadCellForAudio:(id<Audio>)audio
{
    NSIndexPath *indexPath = [self cellIndexPathForAudio:audio];
    if (indexPath != nil) {
        [audioList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (NSIndexPath *)cellIndexPathForAudio:(id<Audio>)audio
{
    NSInteger index = [[self filteredRecords] indexOfObject:audio];
    if (index != NSNotFound) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    }
    return nil;
}

- (AudioGetModel *) nextRequestModel
{
    NSInteger userID = [[SettingsManager sharedInstance] authorizedUserID];
    
    AudioGetModel *model = [[AudioGetModel alloc] init];
    [model setUserID:userID];
    [model setCount:kAudioCountPerRequest];
    [model setOffset:[[self audioRecords] count]];
    
    return model;
}


@end
