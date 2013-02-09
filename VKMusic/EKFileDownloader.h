//
//  FileLoadingOperation.h
//  ImageLoaderTest
//
//  Created by Evgeniy Kirpichenko on 1/17/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EKFileDownloaderDelegate.h"

@interface EKFileDownloader : NSOperation {
    NSMutableArray *observers;
    
    NSMutableData *receivedData;
    NSUInteger expectedDataSize;
    
    NSURLConnection *connection;
}

- (id) initWithURL:(NSURL *) url;

- (void) registerObserver:(id<EKFileDownloaderDelegate>) observer;
- (void) removeObserver:(id<EKFileDownloaderDelegate>) observer;
- (void) removeObservers;


@property (nonatomic,retain,readonly) NSURL *url;
@property (nonatomic,retain,readonly) NSData *response;
@property (nonatomic,retain,readonly) NSError *error;

@property (nonatomic,retain) id userData;


@end

