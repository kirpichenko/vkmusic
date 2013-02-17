//
//  BaseApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParser.h"

typedef id(^ParsingBlock)(ResponseParser *parser,id JSON);

@interface BaseApiRequest : NSObject

- (NSURLRequest *)apiURLRequest;
- (NSString *)apiQuery;
- (ParsingBlock)apiResponseParsingBlock;

@property (nonatomic,copy) NSString *baseURL;
@property (nonatomic,copy) NSString *apiPath;

@property (nonatomic,copy) NSString *accessToken;

@end
