//
//  SettingsManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SettingsManager.h"

static NSString *kAccessTokenKey = @"AccessTokenKey";
static NSString *kAuthorizedUserIDKey = @"AuthorizedUserKey";

@implementation SettingsManager

+ (id) sharedInstance
{
    static SettingsManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SettingsManager alloc] init];
    });
    return sharedInstance;
}

- (id) init
{
    if (self = [super init]) {
        [self loadSettings];
    }
    return self;
}

#pragma mark -
#pragma mark helpers

- (BOOL) isUserAuthorized
{
    return ([[self accessToken] length] > 0 && [self authorizedUserID] != NSNotFound);
}

#pragma mark -
#pragma mark store settings

- (void) saveSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self accessToken] forKey:kAccessTokenKey];
    [defaults setInteger:[self authorizedUserID] forKey:kAuthorizedUserIDKey];
    [defaults synchronize];
}

- (void) loadSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self setAccessToken:[defaults objectForKey:kAccessTokenKey]];
    [self setAuthorizedUserID:[defaults integerForKey:kAuthorizedUserIDKey]];
}

@end
