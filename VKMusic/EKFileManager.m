//
//  EKFileManager.m
//  VKMusic
//
//  Created by Evgeniy Kirpichenko on 2/7/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFileManager.h"
#import "EKFileCache.h"
#import "EKFileDownloader.h"

static NSOperationQueue *kOperationQueue;

@interface EKFileManager () <EKFileDownloaderDelegate>
@property (nonatomic,retain,readwrite) id<EKFileCache> cache;
@end

@implementation EKFileManager

#pragma mark -
#pragma mark life cycle

- (id) init
{
    return [self initWithCache:nil];
}

- (id)initWithCache:(id<EKFileCache>) cache
{
    if (self = [super init]) {
        [self setCache:cache];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kOperationQueue = [[NSOperationQueue alloc] init];
        });
    }
    return self;
}

- (void) dealloc
{
    [self setCache:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark instance methods

- (void)loadFile:(NSURL *)url
{
    [self loadFile:url delegate:nil];
}

- (void)loadFile:(NSURL *)url delegate:(id<EKFileDownloaderDelegate>)delegate
{
    EKFileDownloader *operation = [self executingOperationForURL:url];
    if (operation == nil) {
        operation = [[EKFileDownloader alloc] initWithURL:url];
        [operation registerObserver:self];
        [kOperationQueue addOperation:[operation autorelease]];
    }
    [operation registerObserver:delegate];
}

#pragma mark -
#pragma mark helpers

- (EKFileDownloader *) executingOperationForURL:(NSURL *) url
{
    for (EKFileDownloader *operation in [kOperationQueue operations]) {
        if ([[operation url] isEqual:url]) {
            return operation;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark EKFileDownloaderDelegate

- (void) downloadingFinished:(EKFileDownloader *) loader
{
    [[self cache] cacheFileData:[loader response] forKey:[[loader url] absoluteString]];
}

@end
