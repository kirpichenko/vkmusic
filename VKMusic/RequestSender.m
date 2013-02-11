//
//  RequestManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "RequestSender.h"
#import "RequestConstants.h"
#import "RequestManager.h"
#import "ResponseParser.h"

#import <AFNetworking/AFNetworking.h>

@implementation RequestSender

+ (id) sharedInstance
{
    static RequestSender* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestSender alloc] init];
    });
    return sharedInstance;
}

- (id) init
{
    if (self = [super init]) {
        parser = [[ResponseParser alloc] init];
    }
    return self;
}

- (void) sendAudioGetRequest:(AudioGetModel *) model
                     success:(void(^)(id response)) success
                     failure:(void(^)(NSError *error)) failure;
{
    void(^operationSuccess)(NSURLRequest *,NSHTTPURLResponse *,id) =
    ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            success([parser parseAudioListFromResponse:JSON]);
        }
    };
    
    id operationFailure = [self defaultOperationFailureWithCallback:failure];
    NSURLRequest *request = [[RequestManager sharedInstance] audioGetRequest:model];
    
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:operationSuccess
                                                    failure:operationFailure] start];
}

#pragma mark -
#pragma mark helpers

- (void(^)(NSURLRequest *,NSHTTPURLResponse *, NSError *, id JSON)) defaultOperationFailureWithCallback:(void(^)(NSError *error)) failure
{
    void(^operationFailure)(NSURLRequest *,NSHTTPURLResponse *, NSError *, id JSON) =
    ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (failure) {
            failure(error);
        }
    };
    return operationFailure;
}

@end
