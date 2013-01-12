//
//  EKFilesLoaderDelegate.h
//  EKFilesManager
//
//  Created by Evgeniy Kirpichenko on 10/31/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EKFilesLoaderDelegate <NSObject>
@optional
- (void) fileLoadingWillStartFromURL:(NSURL *) url;
- (void) fileLoadingDidStartFromURL:(NSURL *) url;
- (void) fileLoaded:(NSData *) fileData fromURL:(NSURL *) url;
- (void) fileLoadingFailed:(NSError *) error fromURL:(NSURL *) url;
- (void) fileLoadingCancelledFromURL:(NSURL *) url;
- (void) fileLoadingProgress:(NSNumber *) progress fromURL:(NSURL *) url;
@end
