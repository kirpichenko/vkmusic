//
//  SettingsManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SettingsManager.h"

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
    if (self = [super init])
    {
#ifndef TEST
        [self loadSettings];
#endif
    }
    return self;
}

#pragma mark -
#pragma mark helpers

- (BOOL) isUserAuthorized
{
    return ([self signedUser] != nil);
}

#pragma mark -
#pragma mark store settings

- (void) saveSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[[self signedUser] userID] forKey:kAuthorizedUserIDKey];
    [defaults synchronize];
}

- (void) loadSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userID = [defaults integerForKey:kAuthorizedUserIDKey];

    User *user = [User MR_findFirstByAttribute:@"userID" withValue:@(userID)];
    [self setSignedUser:user];
}

@end
