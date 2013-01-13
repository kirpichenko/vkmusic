//
//  AppDelegate.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AppDelegate.h"
#import "SignInViewController.h"
#import "PlayerViewController.h"

@interface AppDelegate () <SignInViewControllerDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AudioPlayer *player = [AudioPlayer sharedInstance];
    PlayerViewController *controller = [[PlayerViewController alloc] initWithPlayer:player];
    [self.window setRootViewController:controller];
    [self.window makeKeyAndVisible];
    
    [self checkIfUserAuthorized];
    [self registerForNotificationNamed:kUserSignedOut
                              selector:@selector(userSignedOut)];
    return YES;
}

#pragma mark -
#pragma mark helpers

- (void) checkIfUserAuthorized
{
    SettingsManager *settings = [SettingsManager sharedInstance];
    if (![settings isUserAuthorized]) {
        [self showSignInViewControllerAnimated:NO];
    }
    else {
        [[RequestManager sharedInstance] setAccessToken:[settings accessToken]];
    }
}

- (void) showSignInViewControllerAnimated:(BOOL) animated
{
    SignInViewController *controller = [[SignInViewController alloc] init];
    [controller setDelegate:self];
    [[[self window] rootViewController] presentViewController:controller
                                                     animated:animated
                                                   completion:nil];
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

- (void) userSignedOut
{
    [self showSignInViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SignInViewControllerDelegate methods

- (void) userSignedIn:(NSInteger)userID accessToken:(NSString *)token
{
    SettingsManager *settings = [SettingsManager sharedInstance];
    [settings setAccessToken:token];
    [settings setAuthorizedUserID:userID];
    [settings saveSettings];
    
    RequestManager *manager = [RequestManager sharedInstance];
    [manager setAccessToken:token];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignedIn
                                                        object:nil];
}

- (void) userSignInFailed:(NSError *) error
{
    NSLog(@"error = %@",error);
}

#pragma mark -
#pragma mark test


@end
