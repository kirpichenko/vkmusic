//
//  BaseApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BaseApiRequest.h"
#import "ObjectMapping.h"

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
    [NSException raise:@"Exception:" format:@"Implement - (NSString *)apiQuery method in subclass"];
    return nil;
}

- (ObjectMapping *)responseObjectsMapping
{
    [NSException raise:@"Exception" format:@"Implement - (ObjectMapping *)responseObjectsMapping method in subclass"];
    return nil;
}

- (id)parseJSONResponse:(id)JSON
{
    id responseData = [JSON objectForKey:@"response"];
    if (responseData == nil) {
        return nil;
    }
    
    ObjectMapping *objectMapping = [self responseObjectsMapping];
    if ([responseData isKindOfClass:[NSArray class]]) {
        return [self parseArray:responseData withObjectMapping:objectMapping];
    }
    else {
        return [objectMapping mappedObjectWithProperties:responseData];
    }
}

- (id)parseArray:(id)JSON withObjectMapping:(ObjectMapping *)objectMapping
{
    NSMutableArray *parsedList = [NSMutableArray arrayWithCapacity:[JSON count]];
    for (NSDictionary *objectProperties in JSON) {
        id object = [self parseObject:objectProperties withObjectMapping:objectMapping];
        if (object != nil) {
            [parsedList addObject:object];
        }
    }
    return parsedList;
}

- (id)parseObject:(id)JSON withObjectMapping:(ObjectMapping *)objectMapping
{
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return [objectMapping mappedObjectWithProperties:JSON];
    }
    return nil;
}

@end
