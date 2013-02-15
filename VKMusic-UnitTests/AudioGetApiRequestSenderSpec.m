#import "ApiRequestSender.h"
#import "NSURLRequestManager.h"

//using namespace Cedar::Matchers;
//using namespace Cedar::Doubles;

#define EXP_SHORTHAND

#import "Expecta.h"

SPEC_BEGIN(AudioGetApiRequestSenderSpec)

describe(@"AudioGetApiRequestSender", ^{
    [[NSURLRequestManager sharedInstance] setAccessToken:@"token"];
    __block ApiRequestSender *sender;
    AudioGetApiRequest *apiRequest = [[AudioGetApiRequest alloc] init];
    [apiRequest setUserID:1101];
    [apiRequest setCount:20];
    [apiRequest setOffset:40];
    __block NSArray *audioList;

    beforeEach(^{
        
        sender = [[ApiRequestSender alloc] init];
        
        
        
        
        [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse *(NSURLRequest *request, BOOL onlyCheck) {
            if([[[request URL] path] isEqualToString:kAudioGetApiPath])
            {
                return [OHHTTPStubsResponse responseWithFile:@"AudioGetResponse"
                                                 contentType:@"text/json" responseTime:0];
            }
            return nil;
        }];
        
        [sender sendAudioGetApiRequest:apiRequest
                               success:^(id response){
                                   audioList = response;
                               }
                               failure:nil];
    });
    
    it(@"Audio List shouldn't be nil ", ^{
        expect(audioList).willNot.beNil();
    });
    
    it(@"Audio List count should be 3", ^{
        expect([audioList count]).will.equal(3);
    });
    
//    context(@"",^{
//        
//    });
});

SPEC_END
