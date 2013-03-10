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

#import "NSObject+NotificationCenter.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate () <SignInViewControllerDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application beginReceivingRemoteControlEvents];
    [MagicalRecord setupCoreDataStack];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AudioPlayer *player = [AudioPlayer sharedInstance];
    PlayerViewController *controller = [[PlayerViewController alloc] initWithPlayer:player];
    
    [self.window setRootViewController:controller];
    [self.window makeKeyAndVisible];
    
    [self observeNotificationNamed:kUserSignedOut withSelector:@selector(userSignedOut)];
    [self checkIfUserAuthorized];
    
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

- (void) userSignedOut
{
    [self showSignInViewControllerAnimated:NO];
    [[AudioPlayer sharedInstance] stop];
}

#pragma mark -
#pragma mark SignInViewControllerDelegate methods

- (void) userSignedIn:(User *)user
{
    SettingsManager *settings = [SettingsManager sharedInstance];
    [settings setSignedUser:user];
    [settings saveSettings];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignedIn
                                                        object:nil];
}

- (void) userSignInFailed:(NSError *) error
{
    NSLog(@"error = %@",error);
}

#pragma mark -
#pragma mark test

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent
{
    if ([receivedEvent type] == UIEventTypeRemoteControl) {
        [[AudioPlayer sharedInstance] processAudioEvent:[receivedEvent subtype]];
    }
}

@end
