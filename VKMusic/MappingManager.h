//
//  MappingManager.h
//  
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//
//

#import <Foundation/Foundation.h>
#import "ObjectMapping.h"

@interface MappingManager : NSObject

+ (id)sharedInstance;

- (ObjectMapping *)audioMapping;
- (ObjectMapping *)albumMapping;

@end
