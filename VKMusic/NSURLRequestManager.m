//
//  RequestManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSURLRequestManager.h"

@interface NSURLRequestManager ()
@end

@implementation NSURLRequestManager

+ (id) sharedInstance
{
    static NSURLRequestManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NSURLRequestManager alloc] init];
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

- (NSURLRequest *)audioGetApiRequest:(AudioGetApiRequest *)apiRequest
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?uid=%d&access_token=%@&count=%d&offset=%d",
                           kApiURL,
                           kAudioGetApiPath,
                           [apiRequest userID],
                           [self accessToken],
                           [apiRequest count],
                           [apiRequest offset]];
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (NSURLRequest *)albumsGetApiRequest:(AlbumsGetApiRequest *)apiRequest
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?uid=%d&access_token=%@",
                           kApiURL,
                           kAlbumsGetApiPath,
                           /*[apiRequest userID]*/1,
                           @""];
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

@end
