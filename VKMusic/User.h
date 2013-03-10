//
//  User.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 3/10/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineAudio;

@interface User : NSManagedObject

@property (nonatomic) int32_t userID;
@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSSet *audioList;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAudioListObject:(OfflineAudio *)value;
- (void)removeAudioListObject:(OfflineAudio *)value;
- (void)addAudioList:(NSSet *)values;
- (void)removeAudioList:(NSSet *)values;

@end
