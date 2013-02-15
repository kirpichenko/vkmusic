//
//  ResponseParser.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseParser : NSObject

- (NSArray *)parseAudioListFromResponse:(id)response;
- (NSArray *)parseAlbumsListFromResponse:(id)response;

@end
