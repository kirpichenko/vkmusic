//
//  EKFilesLoaderDelegate.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKDownloader;

@protocol EKDownloaderDelegate <NSObject>

@optional
- (void) downloadingWillStart:(EKDownloader *) loader;
- (void) downloadingStarted:(EKDownloader *) loader;

- (void) downloadingFinished:(EKDownloader *) loader;
- (void) downloading:(EKDownloader *) loader inProgress:(NSInteger) progress;

- (void) downloadingFailed:(EKDownloader *) loader;
- (void) downloadingCancelled:(EKDownloader *) loader;

@end
