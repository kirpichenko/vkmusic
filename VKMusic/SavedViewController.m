//
//  SavedViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SavedViewController.h"

#import "OfflineAudio.h"
#import "AudioCell.h"

#import "UITableView+CellCreation.h"

@interface SavedViewController () <UITableViewDataSource,UITabBarDelegate>
@property (nonatomic,strong,readwrite) NSArray *audioRecords;
@end

@implementation SavedViewController

#pragma mark -
#pragma mark life cycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self filterRecords:[searchField text]];
}

- (void)dealloc
{
    [self setAudioRecords:nil];
}

#pragma mark -
#pragma mark insatnce methods

- (void)filterRecords:(NSString *)filter
{
    self.audioRecords = [[OfflineAudioManager sharedInstance] offlineAudioListWithFilter:filter];
    [audioList reloadData];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string
{
    NSString *text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    [self filterRecords:text];
    return YES;
}


@end
