//
//  OAuthResponse.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthResponse : NSObject

- (id) initWithRedirectURL:(NSURL *) url;

@property (nonatomic,readonly) NSURL *redirectURL;

@property (nonatomic,readonly) NSString *accessToken;
@property (nonatomic,readonly) NSInteger userID;
@property (nonatomic,readonly) NSTimeInterval expirationDate;

@property (nonatomic,readonly) NSString *error;

@end
