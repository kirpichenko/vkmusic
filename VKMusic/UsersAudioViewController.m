//
//  UsersAudioViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/4/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "UsersAudioViewController.h"

#import "AudioGetApiRequest.h"
#import "AudioCell.h"
#import "UITableView+CellCreation.h"

@interface UsersAudioViewController ()
@end

@implementation UsersAudioViewController

#pragma mark -
#pragma mark life cycle

- (id)init
{
    if (self = [super init]) {
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
        [[self audioRecordsFull] count] == 0)
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
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioCell *cell = (AudioCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell setDelegate:self];
    return cell;
}

#pragma mark -
#pragma mark requests

- (AudioGetApiRequest *)audioApiRequest
{
    AudioGetApiRequest *model = [[AudioGetApiRequest alloc] init];

    [model setUserID:[[[SettingsManager sharedInstance] signedUser] userID]];
    [model setAlbumID:[self albumID]];
    
    return model;
}


@end
