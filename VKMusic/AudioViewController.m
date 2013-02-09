//
//  AudioViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioViewController.h"

#import "AudioCell.h"

#import "UITableView+CellCreation.h"


@interface AudioViewController () <UISearchBarDelegate>
@property (nonatomic,strong,readwrite) NSArray *audioRecords;
@property (nonatomic,strong,readwrite) NSArray *filteredRecords;
@end

@implementation AudioViewController

@synthesize audioRecords;
@synthesize filteredRecords;

#pragma mark -
#pragma mark life cycle

- (void) dealloc
{
    [self setAudioRecords:nil];
    [self setFilteredRecords:nil];
}

#pragma mark -
#pragma mark instance methods

- (void) audioHaveBeenLoaded:(NSArray *) audio
{
    [self setAudioRecords:audio];
    [self filterRecords:[searchField text]];
}

- (void) filterRecords:(NSString *) filter
{
    if ([filter length] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"artist contains[cd] %@ or title contains[cd] %@",filter,filter];
        [self setFilteredRecords:[audioRecords filteredArrayUsingPredicate:predicate]];
    }
    else {
        [self setFilteredRecords:audioRecords];
    }
    [audioList reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filteredRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<Audio> audio = [filteredRecords objectAtIndex:indexPath.row];
    
    AudioCell *cell = [tableView cellForClass:[AudioCell class]];
    [cell setAudio:audio];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([searchField isFirstResponder]) {
        [searchField resignFirstResponder];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<Audio> audio = [filteredRecords objectAtIndex:indexPath.row];

    AudioPlayer *player = [AudioPlayer sharedInstance];
    [player setAudioList:audioRecords];
    [player playAudioAtIndex:[audioRecords indexOfObject:audio]];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string
{
    NSString *text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    [self filterRecords:text];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }    
    return YES;
}

@end
