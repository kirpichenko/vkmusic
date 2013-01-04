//
//  OAuthResponse.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "OAuthResponse.h"

@interface OAuthResponse ()
@property (nonatomic, strong, readwrite) NSURL *redirectURL;

@property (nonatomic, strong, readwrite) NSString *accessToken;
@property (nonatomic, readwrite) NSInteger userID;
@property (nonatomic, readwrite) NSTimeInterval expirationDate;

@property (nonatomic, strong, readwrite) NSString *error;
@end

@implementation OAuthResponse

#pragma mark -
#pragma mark life cycle

- (id) initWithRedirectURL:(NSURL *) url
{
    if (self = [super init]) {
        [self setRedirectURL:url];
        [self parseQuery];
        [self parseFragment];
    }
    return self;
}

- (void) dealloc
{
    [self setRedirectURL:nil];
    [self setAccessToken:nil];
    [self setError:nil];
}

#pragma mark -
#pragma mark parse response params

- (void) parseQuery
{
    NSDictionary *parsedQuery = [self parsedParams:[[self redirectURL] query]];
    if (parsedQuery) {
        [self setError:[parsedQuery objectForKey:@"error_description"]];
    }
}

- (void) parseFragment
{
    NSDictionary *parsedFragment = [self parsedParams:[[self redirectURL] fragment]];
    [self setAccessToken:[parsedFragment objectForKey:@"access_token"]];
    [self setExpirationDate:[[parsedFragment objectForKey:@"expires_in"] doubleValue]];
    [self setUserID:[[parsedFragment objectForKey:@"user_id"] integerValue]];
}

#pragma mark -
#pragma mark helpers

- (NSDictionary *) parsedParams:(NSString *) paramsString
{
    NSArray *params = [paramsString componentsSeparatedByString:@"&"];
    if ([params count] == 0) {
        return nil;
    }
    
    NSMutableDictionary *parsedParams = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    for (NSString *param in params) {
        NSArray *paramComponents = [param componentsSeparatedByString:@"="];
        if ([paramComponents count] == 2) {
            [parsedParams setObject:[paramComponents objectAtIndex:1]
                             forKey:[paramComponents objectAtIndex:0]];
        }
        else {
            NSLog(@"Wrong number of param components");
        }
    }
    return parsedParams;
}

@end
