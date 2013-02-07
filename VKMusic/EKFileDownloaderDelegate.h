//
//  EKFilesLoaderDelegate.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/3/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKFileDownloader;

@protocol EKFileDownloaderDelegate <NSObject>

@optional
- (void) downloadingWillStart:(EKFileDownloader *) loader;
- (void) downloadingStarted:(EKFileDownloader *) loader;

- (void) downloadingFinished:(EKFileDownloader *) loader;
- (void) downloading:(EKFileDownloader *) loader inProgress:(float) progress;

- (void) downloadingFailed:(EKFileDownloader *) loader;
- (void) downloadingCancelled:(EKFileDownloader *) loader;

@end
