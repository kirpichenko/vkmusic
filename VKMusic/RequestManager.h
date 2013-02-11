//
//  RequestManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestConstants.h"

@interface RequestManager : NSObject

+ (id) sharedInstance;

- (NSURLRequest *) authorizationURLRequest;
- (NSURLRequest *) audioGetRequest:(AudioGetModel *) model;

@property (atomic,strong) NSString *accessToken;

@end
