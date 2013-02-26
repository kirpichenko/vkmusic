//
//  AudioFilteringViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioFilteringViewController.h"

@interface AudioFilteringViewController ()
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
#pragma mark public methods

- (void) audioHaveBeenLoaded:(NSArray *) audio
{
    [self setAudioRecordsFull:audio];
    [self filterRecords:[searchField text]];
}

- (void) filterRecords:(NSString *) filter
{
    if ([filter length] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"artist contains[cd] %@ or title contains[cd] %@",filter,filter];
        [self setAudioRecords:[audioRecordsFull filteredArrayUsingPredicate:predicate]];
    }
    else {
        [self setAudioRecords:audioRecordsFull];
    }
    [audioList reloadData];
}

@end
