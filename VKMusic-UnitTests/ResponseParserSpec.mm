#import "ResponseParser.h"
#import "NSDictionary+LoadFromJsonFile.h"
#import "Audio.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ResponseParserSpec)

describe(@"ResponseParser", ^{
    __block ResponseParser *parser;
    __block id response;
    
    beforeEach(^{
        parser = [[ResponseParser alloc] init];
    });
    
    context(@"Parse Audio", ^{
        __block NSArray *audioList;

        beforeEach(^{
            response = [NSDictionary dictionaryFromJsonFileNamed:@"GetAudioResponse"];
            audioList = [parser parseAudioListFromResponse:response];
        });
        
        it(@"Should contain 3 audio models", ^{
            expect([audioList count]).to(equal(3));
        });
        
        context (@"Audio file parsing",^{
            __block Audio *audio;
            
            beforeEach(^{
                audio = [audioList objectAtIndex:0];
            });
            
            it(@"Audio ID should be 154329402", ^{
                expect([audio audioID]).to(equal(154329402));
            });
            
            it(@"Audio owner ID should be 67339882", ^{
                expect([audio ownerID]).to(equal(67339882));
            });
            
            it(@"Audio artist should be \"The Rasmus\"", ^{
                expect([audio artist]).to(equal(@"The Rasmus"));
            });
            
            it(@"Audio title should be \"Livin in a world without you\"", ^{
                expect([audio title]).to(equal(@"Livin in a world without you"));
            });
            
            it(@"Audio duration should be close to 227", ^{
                expect([audio duration]).to(be_close_to(227));
            });
            
            it(@"Audio url should be"
               @"\"http://cs4617.userapi.com/u44378645/audios/065523adbe9c.mp3\"", ^{
                   NSString *expectedURL = @"http://cs4617.userapi.com/u44378645/audios/065523adbe9c.mp3";
                   expect([audio url]).to(equal(expectedURL));
               });
            
            it(@"Audio lyrics ID should be 4423020",^{
                expect([audio lyricsID]).to(equal(4423020));
            });
        });
    });
});

SPEC_END
