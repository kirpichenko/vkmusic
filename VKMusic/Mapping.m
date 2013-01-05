//
//  Mapping.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "Mapping.h"

@implementation Mapping 

- (id) init
{
    if (self = [super init]) {
        mappingProperties = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) mapProperty:(NSString *) name withKey:(NSString *) key
{
    [mappingProperties setObject:key forKey:name];
}

- (void) mapProperties:(NSArray *) properties
{
    for (NSString *propertyName in properties) {
        [mappingProperties setObject:propertyName forKey:propertyName];
    }
}

- (void) applyForObject:(NSObject *) object withResource:(NSDictionary *) resource
{
    for (NSString *propertyName in [mappingProperties allKeys]) {
        id value = [resource objectForKey:[mappingProperties objectForKey:propertyName]];
        if (value) {
            [object setValue:value forKeyPath:propertyName];
        }    
    }
}

@end
