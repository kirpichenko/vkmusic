//
//  AudioGetModel.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/11/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseApiRequest.h"
#import "OnlineAudio.h"

@interface AudioGetApiRequest : BaseApiRequest

@property (nonatomic,assign) NSInteger userID;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger offset;
@property (nonatomic,assign) NSInteger albumID;

@end
