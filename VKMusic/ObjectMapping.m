//
//  Mapping.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "ObjectMapping.h"

@interface ObjectMapping ()
@property (nonatomic,strong) Class ObjectClass;
@end

@implementation ObjectMapping 

#pragma mark -
#pragma mark life cycle

- (id)initWithObjectClass:(Class)ObjectClass
{
    if (self = [super init]) {
        mappingProperties = [[NSMutableDictionary alloc] init];

        [self setObjectClass:ObjectClass];
    }
    return self;
}


#pragma mark -
#pragma mark instance methods

- (void)mapResourceName:(NSString *)name forPropertyName:(NSString *)key
{
    [mappingProperties setObject:key forKey:name];
}

- (void)mapPropertyNames:(NSArray *)properties
{
    for (NSString *propertyName in properties) {
        [mappingProperties setObject:propertyName forKey:propertyName];
    }
}

- (id)mappedObjectWithProperties:(NSDictionary *)resource
{
    id mappedObject = [[_ObjectClass alloc] init];

    for (NSString *propertyName in [mappingProperties allKeys]) {
        id value = [resource objectForKey:[mappingProperties objectForKey:propertyName]];
        if (value) {
            [mappedObject setValue:value forKeyPath:propertyName];
        }
    }
    
    return mappedObject;
}

@end
