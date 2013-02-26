//
//  AudioSearchApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApiRequest.h"
#import "Audio.h"

@interface AudioSearchApiRequest : BaseApiRequest

@property (nonatomic,copy) NSString *query;
@property (nonatomic,assign) BOOL autoComplete;
@property (nonatomic,assign) BOOL hasLyrics;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger offset;

@end
