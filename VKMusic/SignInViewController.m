//
//  SignInViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SignInViewController.h"
#import "NSURLRequestManager.h"
#import "OAuthResponse.h"

@interface SignInViewController () <UIWebViewDelegate>

@end

@implementation SignInViewController

#pragma mark -
#pragma mark life cycle

- (id) initWithDelegate:(id<SignInViewControllerDelegate>) delegate
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self setDelegate:nil];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [[NSURLRequestManager sharedInstance] authorizationURLRequest];
    [webView setDelegate:self];
    [webView loadRequest:request];
}

- (void) dealloc
{
    [self setDelegate:nil];
    [webView setDelegate:nil];
}

#pragma mark -
#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if ([[url host] isEqualToString:kRedirectUri]) {
        OAuthResponse *response = [[OAuthResponse alloc] initWithRedirectURL:url];
        if ([[response accessToken] length] != 0) {
            [[self delegate] userSignedIn:[response userID]
                              accessToken:[response accessToken]];
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
        [[self delegate] userSignInFailed:error];
    }    
}

@end
