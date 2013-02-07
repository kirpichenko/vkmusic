//
//  EKFileManager.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/7/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EKFileCache.h"
#import "EKFileDownloaderDelegate.h"

@interface EKFileManager : NSObject

- (id)initWithCache:(id<EKFileCache>) cache;

- (void)loadFile:(NSURL *)url;
- (void)loadFile:(NSURL *)url delegate:(id<EKFileDownloaderDelegate>)delegate;

@property (nonatomic,retain,readonly) id<EKFileCache> cache;

@end
