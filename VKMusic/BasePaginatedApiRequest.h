//
//  BasePaginatedApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/10/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BaseApiRequest.h"

@interface BasePaginatedApiRequest : BaseApiRequest

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger offset;

@end
