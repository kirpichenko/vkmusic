//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AudioGetApiRequest.h"
#import "AlbumsGetApiRequest.h"

typedef void(^ApiRequestSuccessBlock)(id response);
typedef void(^ApiRequestFailureBlock)(NSError *error);

@class ResponseParser;

@interface ApiRequestSender : NSObject
{
    ResponseParser *parser;
}

+ (id)sharedInstance;

- (void)sendAudioGetApiRequest:(AudioGetApiRequest *)apiRequest
                       success:(ApiRequestSuccessBlock)success
                       failure:(ApiRequestFailureBlock)failure;
- (void)sendAlbumsGetApiRequest:(AlbumsGetApiRequest *)apiRequest
                        success:(ApiRequestSuccessBlock)success
                        failure:(ApiRequestFailureBlock)failure;

@end
