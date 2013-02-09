//
//  Audio.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Audio <NSObject>

- (NSInteger) audioID;
- (NSString *) artist;
- (NSString *) title;
- (NSTimeInterval) duration;
- (NSURL *) url;

@end
