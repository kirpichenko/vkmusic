//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiRequestConstants.h"

#import "AudioGetApiRequest.h"
#import "AlbumsGetApiRequest.h"

@interface NSURLRequestManager : NSObject

+ (id) sharedInstance;

- (NSURLRequest *)authorizationURLRequest;

- (NSURLRequest *)audioGetApiRequest:(AudioGetApiRequest *)apiRequest;
- (NSURLRequest *)albumsGetApiRequest:(AlbumsGetApiRequest *)apiRequest;

@property (atomic,strong) NSString *accessToken;

@end
