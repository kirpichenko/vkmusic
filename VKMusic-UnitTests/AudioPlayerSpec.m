#import "AudioPlayer.h"
#import "AudioGetApiRequest.h"

SPEC_BEGIN(AudioPlayerSpec)

describe(@"AudioPlayer", ^{
    __block AudioPlayer *player;

    beforeEach(^{
        player = [[AudioPlayer alloc] init];
    });
    
    context(@"empty audio list", ^{
        it(@"state should be stopped", ^{
            expect([player state]).to.equal(kAudioPlayerStateUnconfigured);
        });
        
        it(@"audio list should be nil", ^{
            expect([player audioList] == nil).to.beTruthy();
        });
        
        it(@"playing index shouldn't be found", ^{
            expect([player playingIndex]).to.equal(NSNotFound);
        });
        
        it(@"playing audio should be nil", ^{
            expect([player playingAudio] == nil).to.beTruthy();
        });
    });
    
    context(@"set audio list",^{
        __block NSArray *audioList;
        
        beforeEach(^{
            AudioGetApiRequest *apiRequest = [[AudioGetApiRequest alloc] init];
            NSDictionary *response = [NSDictionary dictionaryFromJsonFileNamed:@"AudioGetResponse"];
            audioList = [apiRequest parseJSONResponse:response];
            
            [player setAudioList:audioList];
        });
        
        it(@"audio list count should be 3", ^{
            expect([[player audioList] count]).to.equal(3);
        });
        
        it(@"state should be stopped", ^{
            expect([player state]).to.equal(kAudioPlayerStateReady);
        });
        
        it(@"playing index should be NSNotFound", ^{
            expect([player playingIndex]).to.equal(NSNotFound);
        });
        
        it(@"playing audio should be nil", ^{
            expect([player playingAudio] == nil).to.beTruthy();
        });
        
        context(@"play audio", ^{
            beforeEach(^{
                [player play];
            });
            
            it(@"state should be playing", ^{
                expect([player state]).to.equal(kAudioPlayerStatePlaying);
            });
            
            it(@"playing index should be 0", ^{
                expect([player playingIndex]).to.equal(0);
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> firstAudio = [audioList objectAtIndex:0];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to.equal([firstAudio audioID]);
            });
        });
        
        context(@"play audio at index", ^{
            beforeEach(^{
                [player playAudioAtIndex:1];
            });
            
            it(@"state should be playing", ^{
                expect([player state]).to.equal(kAudioPlayerStatePlaying);
            });
            
            it(@"playing index should be 1", ^{
                expect([player playingIndex]).to.equal(1);
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> secondAudio = [audioList objectAtIndex:1];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to.equal([secondAudio audioID]);
            });
        });
        
        context(@"pause without previous playing", ^{
            beforeEach(^{
                [player pause];
            });
            
            it(@"state should be ready", ^{
                expect([player state]).to.equal(kAudioPlayerStateReady);
            });
            
            it(@"playing index should be NSNotFound", ^{
                expect([player playingIndex]).to.equal(NSNotFound);
            });
            
            it(@"playing audio should be nil", ^{
                expect([player playingAudio] == nil).to.beTruthy();
            });
        });
        
        context(@"pause during playing",^{
            beforeEach(^{
                [player playAudioAtIndex:1];
                [player pause];
            });
            
            it(@"state should be paused", ^{
                expect([player state]).to.equal(kAudioPlayerStatePaused);
            });
            
            it(@"playing index should be 1", ^{
                expect([player playingIndex]).to.equal(1);
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> secondAudio = [audioList objectAtIndex:1];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to.equal([secondAudio audioID]);
            });
        });
        
        context(@"resume playing",^{
            beforeEach(^{
                [player play];
                [player pause];
                [player resume];
            });
            
            it(@"state should be playing", ^{
                expect([player state]).to.equal(kAudioPlayerStatePlaying);
            });
            
            it(@"playing index should be 0", ^{
                expect([player playingIndex]).to.equal(0);
            });
            
            it(@"playing audio id should be equal to audio id from the set list", ^{
                id<Audio> firstAudio = [audioList objectAtIndex:0];
                id<Audio> playingAudio = [player playingAudio];
                expect([playingAudio audioID]).to.equal([firstAudio audioID]);
            });
        });
        
        context(@"stop playing",^{
            beforeEach(^{
                [player play];
                [player stop];
            });
            
            it(@"state should be unconfigured", ^{
                expect([player state]).to.equal(kAudioPlayerStateUnconfigured);
            });
            
            it(@"audio list should be nil", ^{
                expect([player audioList] == nil).to.beTruthy();
            });
            
            it(@"playing index should be NSNotFound", ^{
                expect([player playingIndex]).to.equal(NSNotFound);
            });
            
            it(@"playing audio shold be nil", ^{
                expect([player playingAudio] == nil).to.beTruthy();
            });
        });
    });
});

SPEC_END
