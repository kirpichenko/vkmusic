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

@property (nonatomic, strong, readonly) NSURL *redirectURL;

@property (nonatomic, strong, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSInteger userID;
@property (nonatomic, readonly) NSTimeInterval expirationDate;

@property (nonatomic, strong, readonly) NSString *error;

@end
