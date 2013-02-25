#import "NSString+TimeFormatting.h"

SPEC_BEGIN(NSStringExtensionsSpec)

describe(@"stringWithTimeInterval:", ^{
    it(@"it should return \"0:35\" for timeInterval 35.20", ^{
        NSString *stringInterval = [NSString stringWithTimeInterval:35.20];
        expect(stringInterval).to.equal(@"0:35");
    });
    
    it(@"it should return \"2:35\" for timeInterval 155.20", ^{
        NSString *stringInterval = [NSString stringWithTimeInterval:155.20];
        expect(stringInterval).to.equal(@"2:35");
    });
    
    it(@"it should return \"1:02:35\" for timeInterval 3755.20", ^{
        NSString *stringInterval = [NSString stringWithTimeInterval:3755.20];
        expect(stringInterval).to.equal(@"1:02:35");
    });
});

SPEC_END
