//
//  OfflineAudio.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/8/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OfflineAudio : NSManagedObject <Audio>

@property (nonatomic, retain) NSString *artist;
@property (nonatomic) int32_t audioID;
@property (nonatomic) float duration;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *audioURL;

@end
