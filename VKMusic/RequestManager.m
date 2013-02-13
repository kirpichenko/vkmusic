//
//  RequestManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "RequestManager.h"

@interface RequestManager ()
@end

@implementation RequestManager

+ (id) sharedInstance
{
    static RequestManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestManager alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *) authorizationURLRequest
{
    NSString *urlString = [NSString stringWithFormat:
                           @"%@?client_id=%@&scope=audio,offline&redirect_uri=%@&"
                           @"display=mobile&response_type=token",
                           kAuthorizationURL,kApplicationID,kRedirectUri];
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (NSURLRequest *) audioGetRequest:(AudioGetRequestObject *) model
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?uid=%d&access_token=%@&count=%d&offset=%d",
                           kApiURL,
                           kAudioGetApiPath,
                           [model userID],
                           [self accessToken],
                           [model count],
                           [model offset]];
    NSLog(@"url = %@",urlString);
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

@end
