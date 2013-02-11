//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AudioGetModel.h"

@class ResponseParser;

@interface RequestSender : NSObject
{
    ResponseParser *parser;
}

+ (id) sharedInstance;

- (void) sendAudioGetRequest:(AudioGetModel *) model
                     success:(void(^)(id response)) success
                     failure:(void(^)(NSError *error)) failure;


@end
