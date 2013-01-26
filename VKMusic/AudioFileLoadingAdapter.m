//
//  AudioFileLoader.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/6/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "AudioFileLoadingAdapter.h"

@interface AudioFileLoadingAdapter () 
@property (nonatomic, strong, readwrite) id<AudioLoaderDelegate> delegate;
@end

@implementation AudioFileLoadingAdapter

#pragma mark -
#pragma mark life cycle

- (id) initWithDelegate:(id<AudioLoaderDelegate>) delegate
{
    if (self = [super init]) {
        [self setDelegate:delegate];
    }
    return self;
}

- (void) dealloc
{
    [self setDelegate:nil];
}

#pragma mark -
#pragma mark EKFilesLoaderDelegate

- (void) fileLoaded:(NSData *) fileData fromURL:(NSURL *) url
{
    if ([[self delegate] respondsToSelector:@selector(audioFileLoaded:fromURL:)]) {
        [[self delegate] audioFileLoaded:fileData fromURL:url];
    }
}

- (void) fileLoadingFailed:(NSError *) error fromURL:(NSURL *) url
{
    if ([[self delegate] respondsToSelector:@selector(audioFileLoadingFailed:fromURL:)]) {
        [[self delegate] audioFileLoadingFailed:error fromURL:url];
    }
}

- (void) fileLoadingProgress:(NSNumber *) progress fromURL:(NSURL *) url
{
    if ([[self delegate] respondsToSelector:@selector(audioFileLoadingProgress:fromURL:)]) {
        [[self delegate] audioFileLoadingProgress:[progress floatValue] fromURL:url];
    }
}

#pragma mark -
#pragma mark equal

- (BOOL) isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [[object delegate] isEqual:[self delegate]];
    }
    return NO;
}

@end
