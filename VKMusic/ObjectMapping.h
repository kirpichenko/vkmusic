//
//  Mapping.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectMapping : NSObject
{
    NSMutableDictionary *mappingProperties;
}

- (id)initWithObjectClass:(Class)ObjectClass;

- (void)mapObjectProperty:(NSString *) name forResource:(NSString *) key;
- (void)mapObjectProperties:(NSArray *) properties;

- (id)mappedObjectWithProperties:(NSDictionary *) resource;

@end
