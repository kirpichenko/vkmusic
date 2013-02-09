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
    NSInteger userID = [[SettingsManager sharedInstance] authorizedUserID];
    RequestSender *sender = [RequestSender sharedInstance];

    __weak UsersAudioViewController *selfController = self;
    [sender sendAudioGetRequestForUser:userID
                               success:^(id response){
                                   [selfController audioHaveBeenLoaded:response];
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
//    id<Audio> audio = [cell audio];
    return cell;
}


#pragma mark -
#pragma mark AudioLoaderDelegate

- (void) saveAudio:(OnlineAudio *) audio
{
    [[OfflineAudioManager sharedInstance] loadAudio:audio delegate:self];
}

- (void) audioFile:(OnlineAudio *) audio saved:(NSData *) audioData
{
    NSLog(@"loaded");
}

- (void) audioFile:(OnlineAudio *) audio loadingInProgress:(float) progress
{
    NSLog(@"progress = %f",progress);
}

- (void) audioFile:(OnlineAudio *) audio loadingFailed:(NSError *) error
{
    NSLog(@"error = %@",[error localizedDescription]);
}

    
@end
