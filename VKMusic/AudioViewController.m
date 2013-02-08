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
@end

@implementation AudioViewController

@synthesize audioRecords;

#pragma mark -
#pragma mark life cycle

- (void) dealloc
{
    [self setAudioRecords:nil];
}

#pragma mark -
#pragma mark instance methods

- (void) filterRecords:(NSString *) filter
{
//    Do nothing
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [audioRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<Audio> audio = [audioRecords objectAtIndex:indexPath.row];
    
    AudioCell *cell = [tableView cellForClass:[AudioCell class]];
    [cell setAudio:audio];
    
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
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }    
    return YES;
}

@end
