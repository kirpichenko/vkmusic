//
//  Album.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/15/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiModel.h"

@interface Album : NSObject <ApiModel>

@property (nonatomic,assign) NSInteger ownerID;
@property (nonatomic,assign) NSInteger albumID;
@property (nonatomic,strong) NSString *title;

@end
