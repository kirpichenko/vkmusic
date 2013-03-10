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

#import "UITableView+CellCreation.h"

@interface PlaylistsViewController () <UITableViewDataSource,UITabBarDelegate>
@property (nonatomic,strong) NSArray *objects;
@end

@implementation PlaylistsViewController

@synthesize objects;

#pragma mark -
#pragma mark life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([objects count] == 0)
    {
        [self loadObjects];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [objects count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"albumCell";
    UITableViewCell *cell = [tableView baseCellWithIdentifier:identifier];
    
    Album *album = [objects objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[album title]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Album *album = [objects objectAtIndex:indexPath.row];
    UsersAudioViewController *controller = [[UsersAudioViewController alloc] init];
    [controller setAlbumID:[album albumID]];
    [[self navigationController] pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark helpers

- (BasePaginatedApiRequest *)objectsApiRequest
{
    AlbumsGetApiRequest *apiRequest = [[AlbumsGetApiRequest alloc] init];
    [apiRequest setUserID:[[[SettingsManager sharedInstance] signedUser] userID]];

    return apiRequest;
}

@end
