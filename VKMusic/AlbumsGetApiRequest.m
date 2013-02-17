//
//  AlbumsGetApiRequest.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/14/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AlbumsGetApiRequest.h"

@implementation AlbumsGetApiRequest

#pragma mark -
#pragma marl instance methods

- (NSString *)apiQuery
{
    return [NSString stringWithFormat:@"uid=%d&count=%d&offset=%d",
            [self userID],
            [self count],
            [self offset]];
}

- (ParsingBlock)apiResponseParsingBlock
{
    ParsingBlock parsingBlock =  ^(ResponseParser *parser,id JSON){
        return [parser parseAlbumsListFromResponse:JSON];
    };
    return parsingBlock;
}


@end
