//
//  NSString+TimeFormatting.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSString+TimeFormatting.h"

static const int secondsPerMinute = 60;
static const int minutesPerHour = 60;

@implementation NSString (TimeFormatting)

+ (NSString *) stringWithTimeInterval:(NSTimeInterval) interval
{
    NSInteger seconds = (int)interval % secondsPerMinute;
    NSInteger hours = (int)interval / secondsPerMinute / minutesPerHour;
    NSInteger minutes = (interval - hours * minutesPerHour * secondsPerMinute) / minutesPerHour;
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"%d:%.2d:%.2d",hours,minutes,seconds];
    }
    return [NSString stringWithFormat:@"%d:%.2d",minutes,seconds];
}

@end
