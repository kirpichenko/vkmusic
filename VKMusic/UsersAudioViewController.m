//
//  UsersAudioViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/4/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "UsersAudioViewController.h"
#import "SignInViewController.h"

@interface UsersAudioViewController ()

@end

@implementation UsersAudioViewController

#pragma mark -
#pragma mark life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self registerForNotificationNamed:kUserSignedIn selector:@selector(userSignedIn)];
        [self registerForNotificationNamed:kUserSignedOut selector:@selector(userSignedOut)];
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark load view

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![[SettingsManager sharedInstance] isUserAuthorized]) {
        [self showSignInViewControllerAnimated:NO];
    }
}

#pragma mark -
#pragma mark notifications

- (void) registerForNotificationNamed:(NSString *) name selector:(SEL) selector
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}

- (void) userSignedIn
{
    NSLog(@"signed in");
}

- (void) userSignedOut
{
    [self showSignInViewControllerAnimated:YES];
    NSLog(@"signed out");
}


#pragma mark -
#pragma mark test

- (IBAction)signOut
{
    SettingsManager *settings = [SettingsManager sharedInstance];
    [settings setAccessToken:nil];
    [settings setAuthorizedUserID:NSNotFound];
    [settings saveSettings];
    
    [self deleteCookies];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignedOut object:nil];
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



- (void) showSignInViewControllerAnimated:(BOOL) animated
{
    SignInViewController *controller = [[SignInViewController alloc] init];
    [self presentViewController:controller animated:animated completion:nil];
}

@end
