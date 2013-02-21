//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseApiRequest.h"

typedef void(^ApiRequestSuccessBlock)(id response);
typedef void(^ApiRequestFailureBlock)(NSError *error);

@class ApiRequestParser;

@interface ApiRequestSender : NSObject
{
    ApiRequestParser *parser;
}

+ (id)sharedInstance;

- (void)sendApiRequest:(BaseApiRequest *)apiRequest
               success:(ApiRequestSuccessBlock)success
               failure:(ApiRequestFailureBlock)failure;

@end
