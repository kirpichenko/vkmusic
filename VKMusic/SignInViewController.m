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
    [webView setDelegate:self];
}

- (void) dealloc
{
    [webView setDelegate:nil];
}

#pragma mark -
#pragma mark actions

- (IBAction)signIn
{
    NSURLRequest *request = [[RequestManager sharedInstance] authorizationURLRequest];
    [webView loadRequest:request];
}


#pragma mark -
#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if ([[url host] isEqualToString:kRedirectUri]) {
        OAuthResponse *response = [[OAuthResponse alloc] initWithRedirectURL:url];
        if ([[response accessToken] length] != 0) {
            NSLog(@"authorized");
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


@end
