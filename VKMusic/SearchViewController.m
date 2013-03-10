//
//  SearchViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SearchViewController.h"
#import "AudioSearchApiRequest.h"

@interface SearchViewController () <UITextFieldDelegate>
@property (nonatomic,copy) NSString *searchKeyword;
@end

@implementation SearchViewController

#pragma mark -
#pragma mark life cycle

- (void)dealloc
{
    [self setSearchKeyword:nil];
}

#pragma mark -
#pragma mark template method

- (BasePaginatedApiRequest *)audioApiRequest
{
    AudioSearchApiRequest *apiRequest = [[AudioSearchApiRequest alloc] init];

    [apiRequest setQuery:[self searchKeyword]];
    [apiRequest setAutoComplete:YES];

    return apiRequest;
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
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setSearchKeyword:[textField text]];
    
    [self clean];
    [self loadAudio];

    [textField resignFirstResponder];

    return YES;
}

@end
