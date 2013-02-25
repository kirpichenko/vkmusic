#import "OAuthResponse.h"

SPEC_BEGIN(OAuthResponseSpec)

describe(@"OAuthResponse", ^{
    __block OAuthResponse *oauthResponse;
    __block NSURL *redirectURL;

    context(@"sign in success",^{
        beforeEach(^{
            redirectURL = [NSURL URLWithString:@"http://REDIRECT_URI#"
                           @"access_token=533bacf01e11f55b536a565b57531ad114461ae8736d6506a3&"
                           @"expires_in=86400&"
                           @"user_id=8492"];
            oauthResponse = [[OAuthResponse alloc] initWithRedirectURL:redirectURL];
        });
        
        afterEach(^{
            oauthResponse = nil;
            redirectURL = nil;
        });
        
        it(@"accessToken should be \"533bacf01e11f55b536a565b57531ad114461ae8736d6506a3\"", ^{
            NSLog(@"resp = %@",oauthResponse);
            expect([oauthResponse accessToken]).to.equal(@"533bacf01e11f55b536a565b57531ad114461ae8736d6506a3");
        });
        
        it(@"expirationDate should be close to 86400", ^{
            expect([oauthResponse expirationDate]).to.beCloseTo(86400);
        });
        
        it(@"user_id should be 8492", ^{
            expect([oauthResponse userID]).to.equal(8492);
        });
    });
    
    context(@"sign in failed", ^{
        beforeEach(^{
            redirectURL = [NSURL URLWithString:@"http://vk.com?"
                           @"error=access_denied&"
                           @"error_description=Authorization+failed"];
            oauthResponse = [[OAuthResponse alloc] initWithRedirectURL:redirectURL];
        });
        
        afterEach(^{
            oauthResponse = nil;
            redirectURL = nil;
        });
        
        it(@"error should be \"Authorization+failed\"", ^{
            expect([oauthResponse error]).to.equal(@"Authorization+failed");
        });
    });
});

SPEC_END
