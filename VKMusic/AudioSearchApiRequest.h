//
//  AudioSearchApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BasePaginatedApiRequest.h"

#import "Audio.h"

@interface AudioSearchApiRequest : BasePaginatedApiRequest

@property (nonatomic,copy) NSString *query;
@property (nonatomic,assign) BOOL autoComplete;

@end
