#import "LyricsGetApiRequest.h"
#import "ApiRequestSender.h"
#import "ApiRequestUtitlites.h"

SPEC_BEGIN(LyricsGetSpecSpec)

describe(@"LyricsGetSpec", ^{
    __block Lyrics *lyrics;

    beforeEach(^{
        LyricsGetApiRequest *apiRequest = [[LyricsGetApiRequest alloc] init];
        [apiRequest setLyricsID:1101];
        
        addRequestHandler(kLyricsGetApiPath, @"LyricsGetResponse");
        
        [[ApiRequestSender sharedInstance] sendApiRequest:apiRequest
                                                  success:^(id response) {
                                                      if (lyrics == nil) {
                                                          lyrics = response;
                                                      }
                                                  }
                                                  failure:nil];
    });
    
    it(@"lyricsID must be 3340553",^{
        expect([lyrics lyricsID]).will.equal(3340553);
    });
    
    it(@"lyrics text must be \"Lyrics text\"", ^{
        expect([lyrics text]).will.equal(@"Lyrics text");
    });
});

SPEC_END
