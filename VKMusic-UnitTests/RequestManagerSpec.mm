#import "RequestManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RequestManagerSpec)

describe(@"RequestManager", ^{
    __block RequestManager *manager;

    beforeEach(^{
        manager = [RequestManager sharedInstance];
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
           NSString *receivedURLString = [[[manager audioGetRequestForUser:1101] URL] absoluteString];
           NSString *expectedURLString = @"https://api.vk.com/method/audio.get?uid=1101&access_token=token";
           
           expect(receivedURLString).to(equal(expectedURLString));
    });
});

SPEC_END
