//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFOAuth2Client/AFOAuth2Client.h>

@interface RequestSender : NSObject

+ (id) sharedInstance;

- (void) sendAuthorizationRequest;

@end
