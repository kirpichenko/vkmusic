#import "AudioPlayer.h"
#import "ResponseParser.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AudioPlayerSpec)

describe(@"AudioPlayer", ^{
    __block AudioPlayer *player;

    beforeEach(^{
        player = [[AudioPlayer alloc] init];
    });
    
    context(@"empty audio list", ^{
        it(@"state should be stopped", ^{
            expect([player state]).to(equal(kAudioPlayerStateUnconfigured));
        });
        
        it(@"audio list should be nil", ^{
            //equal record doesn't work by unknown reason
            //expect([player audioList]).to(be_nil);
            expect([player audioList] == nil).to(be_truthy);
        });
        
        it(@"playing index shouldn't be found", ^{
            expect([player playingIndex]).to(equal(NSNotFound));
        });
        
        it(@"playing audio should be nil", ^{
            //equal record doesn't work by unknown reason
            //expect([player playingAudio]).to(be_nil);
            expect([player playingAudio] == nil).to(be_truthy);
        });
    });
    
    context(@"set audio list",^{
        __block NSArray *audioList;
        
        beforeEach(^{
            ResponseParser *parser = [[ResponseParser alloc] init];
            NSDictionary *response = [NSDictionary dictionaryFromJsonFileNamed:@"GetAudioResponse"];
            audioList = [parser parseAudioListFromResponse:response];
            
            [player setAudioList:audioList];
        });
        
        it(@"audio list count should be 3", ^{
            expect([[player audioList] count]).to(equal(3));
        });
        
        it(@"status should be stopped", ^{
            expect([player state]).to(equal(kAudioPlayerStateReady));
        });
        
        it(@"playing index should be NSNotFound", ^{
            expect([player playingIndex]).to(equal(NSNotFound));
        });
        
        it(@"playing audio should be nil", ^{
            expect([player playingAudio] == nil).to(be_truthy);
        });
    });
});

SPEC_END
