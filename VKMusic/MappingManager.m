//
//  MappingManager.m
//  
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//
//

#import "MappingManager.h"

#import "Album.h"
#import "OnlineAudio.h"

@implementation MappingManager

+ (id) sharedInstance
{
    static MappingManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MappingManager alloc] init];
    });
    return manager;
}

- (ObjectMapping *) audioMapping
{
    ObjectMapping *mapping = [[ObjectMapping alloc] initWithObjectClass:[OnlineAudio class]];
    [mapping mapPropertyNames:@[@"artist",@"duration",@"title",@"url"]];
    [mapping mapResourceName:@"audioID" forPropertyName:@"aid"];
    [mapping mapResourceName:@"lyricsID" forPropertyName:@"lyrics_id"];
    [mapping mapResourceName:@"ownerID" forPropertyName:@"owner_id"];
    return mapping;
}

- (ObjectMapping *)albumMapping
{
    ObjectMapping *mapping = [[ObjectMapping alloc] initWithObjectClass:[Album class]];
    [mapping mapResourceName:@"ownerID" forPropertyName:@"owner_id"];
    [mapping mapResourceName:@"albumID" forPropertyName:@"album_id"];
    [mapping mapPropertyNames:@[@"title"]];
    return mapping;
}

@end
