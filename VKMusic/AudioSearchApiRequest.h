//
//  AudioSearchApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioSearchApiRequest : NSObject

@property (nonatomic,copy) NSString *query;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger offset;

@end