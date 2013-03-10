//
//  AlbumsGetApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/14/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BasePaginatedApiRequest.h"
#import "Album.h"

@interface AlbumsGetApiRequest : BasePaginatedApiRequest

@property (nonatomic,assign) NSInteger userID;

@end
