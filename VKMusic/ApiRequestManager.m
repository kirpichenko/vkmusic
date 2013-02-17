//
//  ApiRequestBuilder.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "ApiRequestManager.h"
#import "BaseApiRequest.h"
#import "ApiRequestConstants.h"
#import "SettingsManager.h"

@implementation ApiRequestManager

#pragma mark -
#pragma mark life cycle

- (id)init
{
    if (self = [super init]) {
        apiPaths = @{NSStringFromClass([AudioSearchApiRequest class]) : kAudioSearchApiPath,
                     NSStringFromClass([AudioGetApiRequest class]) : kAudioGetApiPath,
                     NSStringFromClass([AlbumsGetApiRequest class]) : kAlbumsGetApiPath};
    }
    return self;
}

#pragma mark -
#pragma mark instance methods

- (id)apiRequestTemplateOfClass:(Class)ApiRequestClass
{
    BaseApiRequest *apiRequest = [[ApiRequestClass alloc] init];
    
    [apiRequest setBaseURL:kApiBaseURL];
    [apiRequest setApiPath:[self apiPathForRequestOfClass:ApiRequestClass]];
    [apiRequest setAccessToken:[[SettingsManager sharedInstance] accessToken]];
    
    return apiRequest;
}

#pragma mark -
#pragma mark helpers

- (NSString *)apiPathForRequestOfClass:(Class)ApiRequestClass
{
    return [apiPaths objectForKey:NSStringFromClass(ApiRequestClass)];
}

@end
