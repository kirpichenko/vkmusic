//
//  AudioFilteringViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioFilteringViewController.h"

@interface AudioFilteringViewController ()
@property (nonatomic,strong) NSArray *objects;
@property (nonatomic,strong) NSArray *audioRecordsFull;
@end

@implementation AudioFilteringViewController

@synthesize audioRecordsFull;

#pragma mark -
#pragma mark life cycle

- (void)dealloc
{
    [self setAudioRecordsFull:nil];
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

#pragma mark -
#pragma mark instance methods

- (void) objectsHaveBeenLoaded:(NSArray *)loadedObjects
{
    if ([self audioRecordsFull] == nil)
    {
        [self setAudioRecordsFull:loadedObjects];
    }
    else
    {
        [self setAudioRecordsFull:[audioRecordsFull arrayByAddingObjectsFromArray:loadedObjects]];
    }    
    [self filterRecords:[searchField text]];
}

- (void)clean
{
    [self setAudioRecordsFull:nil];
    [super clean];
}

- (void) filterRecords:(NSString *) filter
{
    if ([filter length] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"artist contains[cd] %@ or title contains[cd] %@",filter,filter];
        [self setObjects:[audioRecordsFull filteredArrayUsingPredicate:predicate]];
    }
    else {
        [self setObjects:audioRecordsFull];
    }
    [objectsList reloadData];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[searchField text] length] == 0)
    {
        [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

@end
