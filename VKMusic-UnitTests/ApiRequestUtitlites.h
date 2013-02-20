//
//  ApiRequestUtitlites.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/15/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#ifndef VKMusic_ApiRequestUtitlites_h
#define VKMusic_ApiRequestUtitlites_h

#import "AudioGetApiRequest.h"
#import "AlbumsGetApiRequest.h"

#pragma mark -
#pragma mark ApiRequests

static AudioGetApiRequest *audioGetApiRequest (int userID, int count, int offset)
{
    ApiRequestManager *manager = [[ApiRequestManager alloc] init];
    AudioGetApiRequest *apiRequest = [manager apiRequestTemplateOfClass:[AudioGetApiRequest class]];

    [apiRequest setUserID:userID];
    [apiRequest setCount:count];
    [apiRequest setOffset:offset];
    
    return apiRequest;
}

static AlbumsGetApiRequest *albumsGetApiRequest(int userID)
{
    ApiRequestManager *manager = [[ApiRequestManager alloc] init];
    AlbumsGetApiRequest *apiRequest = [manager apiRequestTemplateOfClass:[AlbumsGetApiRequest class]];

    [apiRequest setUserID:userID];
    
    return apiRequest;
}

#pragma mark -
#pragma mark helpers

static void addRequestHandler(NSString *apiPath, NSString *fileName)
{
    [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse *(NSURLRequest *request, BOOL onlyCheck) {
        if([[[request URL] path] isEqualToString:apiPath])
        {
            return [OHHTTPStubsResponse responseWithFile:fileName contentType:@"text/json"
                                            responseTime:0];
        }
        return nil;
    }];
}

#endif
