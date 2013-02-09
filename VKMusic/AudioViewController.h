//
//  AudioViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioViewController : UIViewController <UITableViewDataSource>
{
    __weak IBOutlet UITableView *audioList;
    __weak IBOutlet UITextField *searchField;
}

- (void) audioHaveBeenLoaded:(NSArray *) audio;
- (void) filterRecords:(NSString *) filter;

@property (nonatomic,strong,readonly) NSArray *audioRecords;
@property (nonatomic,strong,readonly) NSArray *filteredRecords;

@end
