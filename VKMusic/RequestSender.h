//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ResponseParser;

@interface RequestSender : NSObject
{
    ResponseParser *parser;
}

+ (id) sharedInstance;

- (void) sendAudioGetRequestForUser:(NSInteger) userID
                            success:(void(^)(id response)) success
                            failure:(void(^)(NSError *error)) failure;


@end
