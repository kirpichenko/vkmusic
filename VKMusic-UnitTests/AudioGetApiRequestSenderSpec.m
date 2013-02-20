#import "ApiRequestSender.h"
#import "ApiRequestUtitlites.h"

#define EXP_SHORTHAND

#import "Expecta.h"

SPEC_BEGIN(AudioGetApiRequestSenderSpec)

beforeEach(^{
//    [[NSURLRequestManager sharedInstance] setAccessToken:@"token"];
});

describe(@"AudioGetApiRequestSender", ^{    
    __block ApiRequestSender *sender;
    __block NSArray *audioList;
    
    beforeEach(^{
        addRequestHandler(kAudioGetApiPath, @"AudioGetResponse");

        sender = [[ApiRequestSender alloc] init];
        [sender sendApiRequest:audioGetApiRequest(12, 10, 20)
                       success:^(id response){
                           NSLog(@"audio = %@",response);
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
    
    context(@"First audio validation",^{
        __block OnlineAudio *audio;
        beforeEach(^{
            audio = [audioList objectAtIndex:0];
        });
        
        it(@"audioID should be 154329402", ^{
            expect([audio audioID]).will.equal(154329402);
        });
        
        it(@"artist should be \"The Rasmus\"", ^{
            expect([audio artist]).will.equal(@"The Rasmus");
        });
        
        it(@"duration should be 227", ^{
            expect([audio duration]).will.beCloseTo(227);
        });
        
        it(@"lyrics_id should be 4423020", ^{
            expect([audio lyricsID]).will.equal(4423020);
        });
        
        it(@"ownerID should be equal 67339882", ^{
            expect([audio ownerID]).will.equal(67339882);
        });
        
        it(@"title should be \"Livin in a world without you\"", ^{
            expect([audio title]).will.equal(@"Livin in a world without you");
        });
        
        it(@"url should be http://cs4617.userapi.com/u44378645/audios/065523adbe9c.mp3", ^{
            NSString *url = @"http://cs4617.userapi.com/u44378645/audios/065523adbe9c.mp3";
            expect([[audio url] absoluteString]).will.equal(url);
        });
    });
});

SPEC_END
