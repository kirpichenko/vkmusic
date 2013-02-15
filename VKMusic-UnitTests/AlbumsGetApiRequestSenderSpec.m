#import "ApiRequestSender.h"
#import "ApiRequestUtitlites.h"

#import "Album.h"

#define EXP_SHORTHAND

#import "Expecta.h"

SPEC_BEGIN(AlbumsGetApiRequestSpec)

describe(@"AlbumsGetApiRequest", ^{
    __block ApiRequestSender *sender;
    __block NSArray *albums;

    beforeEach(^{
        addRequestHandler(kAlbumsGetApiPath, @"GetAlbumsResponse");

        sender = [[ApiRequestSender alloc] init];
        [sender sendAlbumsGetApiRequest:albumsGetApiRequest(16)
                                success:^(id response) {
                                    NSLog(@"albums = %@",response);
                                    albums = response;
                                }
                                failure:nil];
    });
    
    it(@"albums count should be 2",^{
        expect([albums count]).will.equal(2);
    });

    context(@"album validation",^{
        __block Album *album;
        beforeEach(^{
            album = [albums lastObject];
        });
        
        it(@"albumID should be 34130455", ^{
            expect([album albumID]).will.equal(34130455);
        });
        
        it(@"ownerID should be 67339882", ^{
            expect([album ownerID]).will.equal(67339882);
        });
        
        it(@"title should be \"Album 1\"", ^{
            expect([album title]).will.equal(@"Album 1");
        });
    });
});

SPEC_END
