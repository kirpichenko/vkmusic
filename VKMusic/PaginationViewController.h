//
//  PaginationViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/10/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BasePaginatedApiRequest.h"

@interface PaginationViewController : UIViewController <UITableViewDelegate>
{
    __weak IBOutlet UITableView *objectsList;
}

- (BasePaginatedApiRequest *)objectsApiRequest;

- (void)loadObjects;
- (void)objectsHaveBeenLoaded:(NSArray *)objects;
- (void)objectsLoadingFailed:(NSError *)error;

- (void)clean;

@property (nonatomic,readonly) NSArray *objects;

@end
