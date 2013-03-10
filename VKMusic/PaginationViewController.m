//
//  PaginationViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/10/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "PaginationViewController.h"
#import "NSObject+NotificationCenter.h"

static NSInteger kObjectsPerRequest = 10;
static NSTimeInterval kLoadMoreDelay = 0.3;

@interface PaginationViewController () <UITableViewDataSource>
@property (nonatomic,strong) NSArray *objects;
@end

@implementation PaginationViewController

@synthesize objects;

#pragma mark -
#pragma mark life cycle

- (id)init
{
    if (self = [super init])
    {
        [self observeNotificationNamed:kUserSignedOut withSelector:@selector(clean)];
    }
    return self;
}

- (void)dealloc
{
    [self stopObserving];
    [self setObjects:nil];
}

#pragma mark -
#pragma mark template methods

- (BasePaginatedApiRequest *)objectsApiRequest
{
    [NSException raise:@"Exception" format:@"Implement objectsApiRequest method in subclasses"];
    return nil;
}

#pragma mark -
#pragma mark instance methods

- (void)loadObjects
{
    if ([[self objects] count] % kObjectsPerRequest != 0)
    {
        return;
    }
    
    BasePaginatedApiRequest *apiRequest = [self objectsApiRequest];
    [apiRequest setOffset:[[self objects] count]];
    [apiRequest setCount:kObjectsPerRequest];
    
    __weak PaginationViewController *controller = self;
    [[ApiRequestSender sharedInstance] sendApiRequest:apiRequest
                                              success:^(id response) {
                                                  [controller objectsHaveBeenLoaded:response];
                                              }
                                              failure:^(NSError *error) {
                                                  [controller objectsLoadingFailed:error];
                                              }];
}

- (void)objectsHaveBeenLoaded:(NSArray *)loadedObjects
{
    if ([self objects] != nil)
    {
        NSArray *newObjects = [[self objects] arrayByAddingObjectsFromArray:loadedObjects];
        [self setObjects:newObjects];
    }
    else {
        [self setObjects:loadedObjects];
    }    
    [objectsList reloadData];
}

- (void)objectsLoadingFailed:(NSError *)error
{
    NSLog(@"audio loading failed %@",error);
}

- (void)clean
{
    [self setObjects:nil];
    [objectsList reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Exception" format:@"Implement tableView:cellForRowAtIndexPath: in subclasses"];
    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row + 1) == ([[self objects] count]) &&
        (indexPath.row + 1) % kObjectsPerRequest == 0)
    {
        [self performSelector:@selector(loadObjects) withObject:nil afterDelay:kLoadMoreDelay];
    }
}

@end
