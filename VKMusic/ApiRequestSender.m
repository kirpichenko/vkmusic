//
//  RequestManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "ApiRequestSender.h"
#import "ApiRequestConstants.h"

#import <AFNetworking/AFNetworking.h>

typedef void(^AFSuccessBlock)(NSURLRequest *,NSHTTPURLResponse *,id);
typedef void(^AFFailureBlock)(NSURLRequest *,NSHTTPURLResponse *, NSError *, id JSON);

@implementation ApiRequestSender

+ (id) sharedInstance
{
    static ApiRequestSender* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ApiRequestSender alloc] init];
    });
    return sharedInstance;
}

#pragma mark -
#pragma mark instance methods

- (void)sendApiRequest:(BaseApiRequest *)apiRequest
               success:(ApiRequestSuccessBlock)success
               failure:(ApiRequestFailureBlock)failure
{
    AFSuccessBlock successBlock = [self successBlockWithCallback:success apiRequest:apiRequest];
    AFFailureBlock failureBlock = [self failureBlockWithCallback:failure];
    
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:[apiRequest apiURLRequest]
                                                     success:successBlock
                                                     failure:failureBlock] start];
}

#pragma mark -
#pragma mark helpers

- (AFSuccessBlock)successBlockWithCallback:(ApiRequestSuccessBlock)success
                                apiRequest:(BaseApiRequest *)apiRequest
{
    AFSuccessBlock successBlock =
    ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            NSLog(@"request = %@, response = %@",[[request URL] absoluteString],JSON);
            success([apiRequest parseJSONResponse:JSON]);
        }
    };
    return successBlock;
}

- (AFFailureBlock)failureBlockWithCallback:(ApiRequestFailureBlock)failure
{
    AFFailureBlock operationFailure =
    ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (failure) {
            failure(error);
        }
    };    
    return operationFailure;
}

@end
