//
//  LyricsGetApiRequest.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BaseApiRequest.h"
#import "Lyrics.h"

@interface LyricsGetApiRequest : BaseApiRequest

@property (nonatomic) NSInteger lyricsID;

@end
