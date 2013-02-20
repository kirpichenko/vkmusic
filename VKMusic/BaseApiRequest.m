//
//  BaseApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BaseApiRequest.h"

@implementation BaseApiRequest

#pragma mark -
#pragma mark life cycle

- (void)dealloc
{
    [self setBaseURL:nil];
    [self setApiPath:nil];
    
    [self setAccessToken:nil];
}

#pragma mark -
#pragma mark public methods

- (NSURLRequest *)apiURLRequest
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@%@?access_token=%@",
                                  [self baseURL],
                                  [self apiPath],
                                  [self accessToken]];
    NSString *query = [self apiQuery];
    if (query != nil) {
        [urlString appendFormat:@"&%@",query];
    }

    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (NSString *)apiQuery
{
    [NSException raise:@"Exception:" format:@"Implement query method in subclass"];
    return nil;
}

- (ParsingBlock)apiResponseParsingBlock
{
    [NSException raise:@"Exception:" format:@"Implement apiResponseParsingBlock method in subclass"];
    return nil;
}

@end
