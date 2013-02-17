//
//  PlaylistsViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PlaylistsViewController.h"
#import "UsersAudioViewController.h"
#import "AlbumsGetApiRequest.h"

#import "Album.h"

#import "UITableView+CellCreation.h"

@interface PlaylistsViewController () <UITableViewDataSource,UITabBarDelegate>
@property (nonatomic,strong) NSArray *albums;
@end

@implementation PlaylistsViewController

@synthesize albums;

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAlbums];
}

- (void)viewDidUnload {
    albumsList = nil;
    [super viewDidUnload];
}


- (void)dealloc
{
    [self setAlbums:nil];
}

#pragma mark -
#pragma mark load albums

- (void)loadAlbums
{
    __weak PlaylistsViewController *playlist = self;
    [[ApiRequestSender sharedInstance] sendApiRequest:[self albumsGetApiRequest]
                                              success:^(id response) {
                                                  [playlist albumsAreLoaded:response];
                                              }
                                              failure:^(NSError *error) {
                                                  [playlist albumsLoadingFailed:error];
                                              }];
}

- (void)albumsAreLoaded:(NSArray *)theAlbums
{
    albums = theAlbums;
    [albumsList reloadData];
    
}

- (void)albumsLoadingFailed:(NSError *)error
{
    NSLog(@"error = %@",error);
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [albums count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"albumCell";
    UITableViewCell *cell = [tableView baseCellWithIdentifier:identifier];
    
    Album *album = [albums objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[album title]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Album *album = [[self albums] objectAtIndex:indexPath.row];
    UsersAudioViewController *controller = [[UsersAudioViewController alloc] init];
    [controller setAlbumID:[album albumID]];
    [[self navigationController] pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark helpers

- (AlbumsGetApiRequest *)albumsGetApiRequest
{
    Class ApiRequestClass = [AlbumsGetApiRequest class];

    ApiRequestManager *requestManager = [[ApiRequestManager alloc] init];
    AlbumsGetApiRequest *apiRequest = [requestManager apiRequestTemplateOfClass:ApiRequestClass];
    [apiRequest setUserID:[[SettingsManager sharedInstance] authorizedUserID]];

    return apiRequest;
}

@end
