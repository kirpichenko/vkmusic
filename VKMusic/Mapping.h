//
//  Mapping.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mapping : NSObject
{
    NSMutableDictionary *mappingProperties;
}

- (void) mapProperty:(NSString *) name withKey:(NSString *) key;
- (void) mapProperties:(NSArray *) properties;

- (void) applyForObject:(NSObject *) object withResource:(NSDictionary *) resource;

@end
