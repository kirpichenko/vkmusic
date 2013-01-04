//
//  SignInViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SignInViewController.h"
#import "RequestManager.h"
#import "OAuthResponse.h"

@interface SignInViewController () <UIWebViewDelegate>

@end

@implementation SignInViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [[RequestManager sharedInstance] authorizationURLRequest];
    [webView setDelegate:self];
    [webView loadRequest:request];
}

- (void) dealloc
{
    [webView setDelegate:nil];
}

#pragma mark -
#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if ([[url host] isEqualToString:kRedirectUri]) {
        NSLog(@"url = %@",url);
        OAuthResponse *response = [[OAuthResponse alloc] initWithRedirectURL:url];
        if ([[response accessToken] length] != 0) {
            [self saveAuthorizedUser:response];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignedIn object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        return NO;
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSURL *openingURL = [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey];
    if (![[openingURL host] isEqualToString:kRedirectUri]) {
        NSLog(@"fail = %@",NSStringFromClass([openingURL class]));
    }    
}

#pragma mark -
#pragma mark helpers

- (void) saveAuthorizedUser:(OAuthResponse *) response
{
    SettingsManager *settings = [SettingsManager sharedInstance];
    [settings setAccessToken:[response accessToken]];
    [settings setAuthorizedUserID:[response userID]];
    [settings saveSettings];
}

@end
