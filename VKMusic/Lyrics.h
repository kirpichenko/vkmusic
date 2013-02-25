//
//  Lyrics.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "BaseApiRequest.h"
#import "ApiModel.h"

@interface Lyrics : NSObject <ApiModel>

@property (nonatomic) NSInteger lyricsID;
@property (nonatomic,copy) NSString *text;

@end
