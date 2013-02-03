//
//  FileLoadingOperation.h
//  ImageLoaderTest
//
//  Created by Evgeniy Kirpichenko on 1/17/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFilesCache.h"
#import "EKDownloaderDelegate.h"

@interface EKDownloader : NSObject {
    NSMutableArray *observers;
    NSMutableData *receivedData;
    NSUInteger expectedDataSize;
}

@property (nonatomic, strong, readonly) NSURL *url;

@property (nonatomic, strong) NSData *response;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id userData;

@property (nonatomic, readonly) BOOL executing;
@property (nonatomic, readonly) BOOL finished;
@property (nonatomic, readonly) BOOL cancelled;

- (id) initWithURL:(NSURL *) url filesCache:(id<EKFilesCache>) cache;
- (id) initWithURL:(NSURL *) url;

- (void) start;
- (void) cancel;

- (void) registerObserver:(id<EKDownloaderDelegate>) observer;
- (void) removeObserver:(id<EKDownloaderDelegate>) observer;
- (void) removeObservers;

@end

