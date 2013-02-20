//
//  MappingManager.m
//  
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//
//

#import "MappingManager.h"

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

- (Mapping *) audioMapping
{
    Mapping *mapping = [[Mapping alloc] init];
    [mapping mapProperties:@[@"artist",@"duration",@"title"]];
    [mapping mapProperty:@"audioID" withKey:@"aid"];
    [mapping mapProperty:@"lyricsID" withKey:@"lyrics_id"];
    [mapping mapProperty:@"ownerID" withKey:@"owner_id"];
    return mapping;
}

- (Mapping *)albumMapping
{
    Mapping *mapping = [[Mapping alloc] init];
    [mapping mapProperty:@"ownerID" withKey:@"owner_id"];
    [mapping mapProperty:@"albumID" withKey:@"album_id"];
    [mapping mapProperties:@[@"title"]];
    return mapping;
}

@end
