//
//  AudioFileLoader.h
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKFilesLoaderDelegate.h"

@protocol AudioLoaderDelegate <NSObject>
@optional
- (void) audioFileLoaded:(NSData *) data fromURL:(NSURL *) url;
- (void) audioFileLoadingProgress:(float) progress fromURL:(NSURL *) url;
- (void) audioFileLoadingFailed:(NSError *) error fromURL:(NSURL *) url;
@end

@interface AudioFileLoadingAdapter : NSObject <EKFilesLoaderDelegate>

- (id) initWithDelegate:(id<AudioLoaderDelegate>) delegate;

@property (nonatomic, strong, readonly) id<AudioLoaderDelegate> delegate;

@end
