//
//  AudioGetModel.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/11/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BasePaginatedApiRequest.h"
#import "OnlineAudio.h"

@interface AudioGetApiRequest : BasePaginatedApiRequest

@property (nonatomic,assign) NSInteger userID;
@property (nonatomic,assign) NSInteger albumID;

@end
