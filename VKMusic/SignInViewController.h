//
//  SignInViewController.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignInViewControllerDelegate <NSObject>
- (void) userSignedIn:(NSInteger) userID accessToken:(NSString *) token;
- (void) userSignInFailed:(NSError *) error;
@end

@interface SignInViewController : UIViewController
{
    __weak IBOutlet UIWebView *webView;
}

- (id) initWithDelegate:(id<SignInViewControllerDelegate>) delegate;

@property (nonatomic, weak) id<SignInViewControllerDelegate> delegate;

@end
