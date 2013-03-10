//
//  SettingsManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface SettingsManager : NSObject

+ (id) sharedInstance;

- (BOOL) isUserAuthorized;
- (void) saveSettings;

@property(nonatomic,strong) User *signedUser;

@end
