//
//  RequestManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "ApiRequestSender.h"
#import "ApiRequestConstants.h"
#import "NSURLRequestManager.h"
#import "ResponseParser.h"

#import <AFNetworking/AFNetworking.h>
#import <objc/objc-runtime.h>

typedef void(^AFSuccessBlock)(NSURLRequest *,NSHTTPURLResponse *,id);
typedef void(^AFFailureBlock)(NSURLRequest *,NSHTTPURLResponse *, NSError *, id JSON);
typedef id(^ParsingBlock)(id);

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

- (id) init
{
    if (self = [super init]) {
        parser = [[ResponseParser alloc] init];
    }
    return self;
}

- (void)sendAudioGetApiRequest:(AudioGetApiRequest *)apiRequest
                       success:(ApiRequestSuccessBlock)success
                       failure:(ApiRequestFailureBlock)failure
{
    NSURLRequest *request = [[NSURLRequestManager sharedInstance] audioGetApiRequest:apiRequest];
    ParsingBlock parsingBlock = ^(id JSON){
        return [parser parseAudioListFromResponse:JSON];
    };
    
    [self sendNSURLRequest:request success:success failure:failure parsing:parsingBlock];
}

- (void)sendAlbumsGetApiRequest:(AlbumsGetApiRequest *)apiRequest
                        success:(ApiRequestSuccessBlock)success
                        failure:(ApiRequestFailureBlock)failure
{
    NSURLRequest *request = [[NSURLRequestManager sharedInstance] albumsGetApiRequest:apiRequest];
    ParsingBlock parsingBlock = ^(id JSON){
        return [parser parseAudioListFromResponse:JSON];
    };
    
    [self sendNSURLRequest:request success:success failure:failure parsing:parsingBlock];
}

#pragma mark -
#pragma mark helpers

- (void)sendNSURLRequest:(NSURLRequest *)request
                 success:(ApiRequestSuccessBlock)success
                 failure:(ApiRequestFailureBlock)failure
                 parsing:(ParsingBlock)parsing
{
    AFSuccessBlock successBlock = [self successBlockWithCallback:success parsingBlock:parsing];
    AFFailureBlock failureBlock = [self failureBlockWithCallback:failure];
    
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                     success:successBlock
                                                     failure:failureBlock] start];
    NSLog(@"start");
}

- (AFSuccessBlock)successBlockWithCallback:(ApiRequestSuccessBlock)success
                              parsingBlock:(id(^)(id))parsingBlock
{
    AFSuccessBlock successBlock =
    ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            NSLog(@"success JSON = %@",JSON);
            success(parsingBlock(JSON));
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
