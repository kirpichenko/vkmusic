//
//  SignInViewController.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "SignInViewController.h"
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
    
    NSString *authorizationLink = [self authotizationLink];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:authorizationLink]];

    [webView setDelegate:self];
    [webView loadRequest:urlRequest];
}

- (void) dealloc
{
    NSLog(@"dealloc ");
    [self setDelegate:nil];
    [webView setDelegate:nil];
}

#pragma mark -
#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSLog(@"url = %@",url);
    if ([[url host] isEqualToString:kRedirectUri]) {
        OAuthResponse *response = [[OAuthResponse alloc] initWithRedirectURL:url];
        if ([[response accessToken] length] != 0) {
            [self userSignedInWithOAuthResponse:response];
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

#pragma mark -
#pragma mark helpers

- (NSString *)authotizationLink
{
    return [NSString stringWithFormat:@"%@?client_id=%@&scope=audio,offline&"
            @"redirect_uri=%@&display=mobile&response_type=token",
            kAuthorizationURL,
            kApplicationID,
            kRedirectUri];
}

- (void)userSignedInWithOAuthResponse:(OAuthResponse *)response
{
    User *user = [User MR_findFirstByAttribute:@"userID" withValue:@([response userID])];
    if (user == nil) {
        user = [User MR_createEntity];
        [user setUserID:[response userID]];
    }
    [user setAccessToken:[response accessToken]];
    
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfAndWait];
    [self notifyDelegateUserSigned:user];
}

- (void)notifyDelegateUserSigned:(User *)user
{
    if ([[self delegate] respondsToSelector:@selector(userSignedIn:)])
    {
        [[self delegate] userSignedIn:user];
    }
}

@end
