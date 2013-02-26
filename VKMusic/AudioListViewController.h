//
//  AudioViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioListViewController : UIViewController <UITableViewDataSource>
{
    __weak IBOutlet UITableView *audioList;
}

- (void)audioHaveBeenLoaded:(NSArray *)audio;
- (void)audioLoadingFailed:(NSError *)error;

@property (nonatomic,strong) NSArray *audioRecords;

@end
