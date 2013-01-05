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
    [mapping mapProperties:@[@"artist",@"duration",@"title",@"url"]];
    [mapping mapProperty:@"audioID" withKey:@"aid"];
    [mapping mapProperty:@"lyricsID" withKey:@"lyrics_id"];
    [mapping mapProperty:@"ownerID" withKey:@"owner_id"];
    return mapping;
}

@end