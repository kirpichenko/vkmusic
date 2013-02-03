//
//  OfflineAudio.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CachedAudio : NSManagedObject

@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * audioID;

@end
