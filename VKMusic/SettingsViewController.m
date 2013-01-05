//
//  SettingsViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

#pragma mark -
#pragma mark actions

- (IBAction) signOut
{
    [self forgetAuthorizedUser];
    [self deleteCookies];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignedOut object:nil];
}

#pragma mark -
#pragma mark helpers

- (void) forgetAuthorizedUser
{
    SettingsManager *settings = [SettingsManager sharedInstance];
    [settings setAccessToken:nil];
    [settings setAuthorizedUserID:NSNotFound];
    [settings saveSettings];
    
    RequestManager *manager = [RequestManager sharedInstance];
    [manager setAccessToken:nil];
}

- (void) deleteCookies
{
    NSHTTPCookieStorage* cookiesStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookiesStorage cookies];
    for (NSHTTPCookie* cookie in cookies) {
        [cookiesStorage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end