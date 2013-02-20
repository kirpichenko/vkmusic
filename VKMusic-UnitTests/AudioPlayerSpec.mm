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
        
        it(@"state should be stopped", ^{
            expect([player state]).to(equal(kAudioPlayerStateReady));
        });
        
        it(@"playing index should be NSNotFound", ^{
            expect([player playingIndex]).to(equal(NSNotFound));
        });
        
        it(@"playing audio should be nil", ^{
            expect([player playingAudio] == nil).to(be_truthy);
        });
        
        context(@"play audio", ^{
            beforeEach(^{
                [player play];
            });
            
            it(@"state should be playing", ^{
                expect([player state]).to(equal(kAudioPlayerStatePlaying));
            });
            
            it(@"playing index should be 0", ^{
                expect([player playingIndex]).to(equal(0));
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> firstAudio = [audioList objectAtIndex:0];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to(equal([firstAudio audioID]));
            });
        });
        
        context(@"play audio at index", ^{
            beforeEach(^{
                [player playAudioAtIndex:1];
            });
            
            it(@"state should be playing", ^{
                expect([player state]).to(equal(kAudioPlayerStatePlaying));
            });
            
            it(@"playing index should be 1", ^{
                expect([player playingIndex]).to(equal(1));
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> secondAudio = [audioList objectAtIndex:1];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to(equal([secondAudio audioID]));
            });
        });
        
        context(@"pause without previous playing", ^{
            beforeEach(^{
                [player pause];
            });
            
            it(@"state should be ready", ^{
                expect([player state]).to(equal(kAudioPlayerStateReady));
            });
            
            it(@"playing index should be NSNotFound", ^{
                expect([player playingIndex]).to(equal(NSNotFound));
            });
            
            it(@"playing audio should be nil", ^{
                expect([player playingAudio] == nil).to(be_truthy);
            });
        });
        
        context(@"pause during playing",^{
            beforeEach(^{
                [player playAudioAtIndex:1];
                [player pause];
            });
            
            it(@"state should be paused", ^{
                expect([player state]).to(equal(kAudioPlayerStatePaused));
            });
            
            it(@"playing index should be 1", ^{
                expect([player playingIndex]).to(equal(1));
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> secondAudio = [audioList objectAtIndex:1];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to(equal([secondAudio audioID]));
            });
        });
        
        context(@"resume playing",^{
            beforeEach(^{
                [player play];
                [player pause];
                [player resume];
            });
            
            it(@"state should be playing", ^{
                expect([player state]).to(equal(kAudioPlayerStatePlaying));
            });
            
            it(@"playing index should be 0", ^{
                expect([player playingIndex]).to(equal(0));
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> firstAudio = [audioList objectAtIndex:0];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to(equal([firstAudio audioID]));
            });
        });
        
        context(@"stop playing",^{
            beforeEach(^{
                [player play];
                [player stop];
            });
            
            it(@"state should be unconfigured", ^{
                expect([player state]).to(equal(kAudioPlayerStateUnconfigured));
            });
            
            it(@"audio list should be nil", ^{
                expect([player audioList] == nil).to(be_truthy);
            });
            
            it(@"playing index should be NSNotFound", ^{
                expect([player playingIndex]).to(equal(NSNotFound));
            });
            
            it(@"playing audio shold be nil", ^{
                expect([player playingAudio] == nil).to(be_truthy);
            });
        });
    });
});

SPEC_END
