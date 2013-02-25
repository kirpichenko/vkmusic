//
//  AlbumsGetApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/14/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApiRequest.h"
#import "Album.h"

@interface AlbumsGetApiRequest : BaseApiRequest

@property (nonatomic,assign) NSInteger userID;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger offset;

@end
