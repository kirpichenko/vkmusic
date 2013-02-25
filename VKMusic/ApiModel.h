//
//  ApiModel.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectMapping.h"

@protocol ApiModel <NSObject>
+ (ObjectMapping *)apiResponseMapping;
@end
