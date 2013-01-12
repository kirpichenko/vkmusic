//
//  FileLoadingOperation.h
//  ImageLoaderTest
//
//  Created by Evgeniy Kirpichenko on 1/17/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFilesLoaderDelegate.h"
#import "EKFilesCache.h"

@interface EKFilesLoader : NSObject {
    NSMutableArray *observers;
    NSURLConnection *connection;
    
    NSMutableData *receivedData;
    NSUInteger expectedDataSize;
}

@property (nonatomic, retain, readonly) NSURL *url;

@property (nonatomic, readonly) BOOL executing;
@property (nonatomic, readonly) BOOL finished;
@property (nonatomic, readonly) BOOL cancelled;

- (id) initWithURL:(NSURL *) url filesCache:(id<EKFilesCache>) cache;
- (id) initWithURL:(NSURL *) url;

- (void) start;
- (void) cancel;

- (void) registerObserver:(id<EKFilesLoaderDelegate>) observer;
- (void) removeObserver:(id<EKFilesLoaderDelegate>) observer;
- (void) removeObservers;

@end

