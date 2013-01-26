//
//  NSString+TimeFormatting.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeFormatting)

+ (NSString *) stringWithTimeInterval:(NSTimeInterval) interval;

@end
