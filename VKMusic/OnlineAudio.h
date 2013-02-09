//
//  Audio.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/5/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Audio.h"

@interface OnlineAudio : NSObject <Audio>

@property (nonatomic) NSInteger audioID;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSInteger lyricsID;
@property (nonatomic) NSInteger ownerID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *url;

@end
