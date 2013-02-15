//
//  MappingManager.h
//  
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//
//

#import <Foundation/Foundation.h>
#import "Mapping.h"

@interface MappingManager : NSObject

+ (id)sharedInstance;

- (Mapping *)audioMapping;
- (Mapping *)albumMapping;

@end
