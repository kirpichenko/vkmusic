#import "NSURLRequestManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(NSURLRequestManagerSpec)

describe(@"NSURLRequestManager", ^{
    __block NSURLRequestManager *manager;

    beforeEach(^{
        manager = [NSURLRequestManager sharedInstance];
        [manager setAccessToken:@"token"];
    });
    
    it(@"Authorization request should be"
       @"https://oauth.vk.com/authorize?client_id=3335254&scope=audio,offline&"
       @"redirect_uri=vkmusic.com&display=mobile&response_type=token", ^{
           
           NSString *receivedURLString = [[[manager authorizationURLRequest] URL] absoluteString];
           NSString *expectedURLString = @"https://oauth.vk.com/authorize?"
           @"client_id=3335254&scope=audio,offline&redirect_uri=vkmusic.com&"
           @"display=mobile&response_type=token";
        
           expect(receivedURLString).to(equal(expectedURLString));
    });
    
    it(@"Audio get request for user with id=1101 should be"
       @"https://api.vk.com/method/audio.get?uid=1101&access_token=token", ^{
           AudioGetApiRequest *apiRequest = [[AudioGetApiRequest alloc] init];
           [apiRequest setUserID:1101];
           [apiRequest setCount:20];
           [apiRequest setOffset:40];
           
           NSString *receivedURLString = [[[manager audioGetApiRequest:apiRequest] URL] absoluteString];
           NSString *expectedURLString = @"https://api.vk.com/method/audio.get?uid=1101&access_token=token&count=20&offset=40";
           
           expect(receivedURLString).to(equal(expectedURLString));
    });
});

SPEC_END
