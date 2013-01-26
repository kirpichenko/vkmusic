//
//  EKFileManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 1/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFileManager.h"
#import "EKFilesLoader.h"

@interface EKFileManager () <EKFilesLoaderDelegate>
@property (nonatomic, strong) id<EKFilesCache> cache;
@end

@implementation EKFileManager

- (id) initWithCache:(id<EKFilesCache>) cache
{
    if (self = [super init]) {
        [self setCache:cache];
        loadingQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) getFileFromURL:(NSURL *) url delegate:(id<EKFilesLoaderDelegate>) delegate
{
    EKFilesLoader *loader = [self loaderForURL:url];
    if (loader) {
        [loader registerObserver:delegate];
    }
    else {
        NSData *fileData = [[self cache] cachedFileDataForKey:[url absoluteString]];
        if (fileData != nil) {
            if ([delegate respondsToSelector:@selector(fileLoaded:fromURL:)]) {
                [delegate fileLoaded:fileData fromURL:url];
            }
        }
        else {
            loader = [[EKFilesLoader alloc] initWithURL:url filesCache:[self cache]];
            [loader registerObserver:delegate];
            [loader registerObserver:self];
            [loadingQueue addObject:loader];
            
            if ([loadingQueue count] == 1) {
                [loader start];
            }
        }
    }
    
}

- (EKFilesLoader *) loaderForURL:(NSURL *) url
{
    for (EKFilesLoader *loader in loadingQueue) {
        if ([[loader url] isEqual:url]) {
            return loader;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark EKFilesLoaderDelegate

- (void) fileLoaded:(NSData *) fileData fromURL:(NSURL *) url
{
    EKFilesLoader *loader = [self loaderForURL:url];
    [loadingQueue removeObject:loader];
    
    if ([loadingQueue count] > 0) {
        loader = [loadingQueue objectAtIndex:0];
        [loader start];
    }
}

@end
