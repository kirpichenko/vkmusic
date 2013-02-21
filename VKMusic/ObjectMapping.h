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

- (void)mapResourceName:(NSString *) name forPropertyName:(NSString *) key;
- (void)mapPropertyNames:(NSArray *) properties;

- (id)mappedObjectWithProperties:(NSDictionary *) resource;

@end
