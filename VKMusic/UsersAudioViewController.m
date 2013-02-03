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

#import "OfflineAudioManager.h"

@interface UsersAudioViewController ()
    <UITableViewDataSource,
    UITableViewDelegate,
    AudioDownloadingDelegate,
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
                               success:^(id response) {
                                   [selfController setAudioRecords:response];
                                   [audioList reloadData];
                               }
                               failure:^(NSError *error) {
                                   NSLog(@"fail = %@",error);
                               }];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self audioRecords] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnlineAudio *audio = [[self audioRecords] objectAtIndex:indexPath.row];

    AudioCell *cell = [tableView cellForClass:[AudioCell class]];
    [cell setAudio:audio];
    [cell setDelegate:self];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AudioPlayer *player = [AudioPlayer sharedInstance];
    [player setAudioList:[self audioRecords]];
    [player playAudioAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark AudioLoaderDelegate

- (void) saveAudio:(OnlineAudio *) audio
{
//    [[OfflineAudioManager sharedInstance] audioFileFromURL:[audio url]
//                                                delegate:self];
}

- (void) audioFileLoaded:(NSData *) data fromURL:(NSURL *) url
{
    NSLog(@"loaded");
}

- (void) audioFileLoadingProgress:(float) progress fromURL:(NSURL *) url
{
    NSLog(@"progress = %f",progress);
}

- (void) audioFileLoadingFailed:(NSError *) error fromURL:(NSURL *) url
{
    NSLog(@"error = %@",error);
}

    
@end
