//
//  FileLoadingOperation.m
//  ImageLoaderTest
//
//  Created by Evgeniy Kirpichenko on 1/17/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import "EKFilesLoader.h"

@interface EKFilesLoader ()
@property (nonatomic, readwrite) BOOL executing;
@property (nonatomic, readwrite) BOOL finished;
@property (nonatomic, readwrite) BOOL cancelled;
@property (nonatomic, retain, readwrite) NSURL *url;
@property (nonatomic, retain) id<EKFilesCache> filesCache;
@end

@implementation EKFilesLoader

#pragma mark -
#pragma mark life cycle

- (id) initWithURL:(NSURL *) url filesCache:(id<EKFilesCache>) cache
{
    if (self = [super init]) {
        [self setUrl:url];
        [self setFilesCache:cache];
        
        observers = [[NSMutableArray alloc] init];
        receivedData = [[NSMutableData alloc] init];
        
        [self setExecuting:NO];
        [self setFinished:NO];
        
        [self createConnectionWithURL:url];
    }
    return self;
}

- (id) initWithURL:(NSURL *) url
{
    return [self initWithURL:url filesCache:nil];
}

- (id) init
{
    [NSException raise:@"Exception:"
                format:@"Use initWithUrl:, initWithURL:filesCache: methods to create loader"];
    return nil;
}

- (void) dealloc
{
    [observers release];
    [receivedData release];
    [connection release];

    [self setUrl:nil];
    [self setFilesCache:nil];
    
    [super dealloc];
}

#pragma mark -
#pragma mark connection

- (void) createConnectionWithURL:(NSURL *) url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self url]];
    connection = [[NSURLConnection alloc] initWithRequest:request
                                                 delegate:self
                                         startImmediately:NO];
}

#pragma mark -
#pragma mark loading

- (void) start
{
    if (![self executing]) {
        if (![self cancelled]) {
            [self setExecuting:YES];
            [self notifyObserversWithSelector:@selector(fileLoadingWillStartFromURL:)
                                   withObject:[self url]
                                   withObject:nil];
            [connection start];
        }
    }
    else {
//        [NSException raise:@"Exception:" format:@"Loading already started"];
        NSLog(@"loading already started");
    }
}

- (void) cancel
{
    [self setCancelled:YES];
    [self setExecuting:NO];
    
    [connection cancel];
    [self notifyObserversWithSelector:@selector(fileLoadingCancelledFromURL:)
                           withObject:[self url]
                           withObject:nil];
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error
{
    if (![self cancelled]) {
        [self notifyObserversWithSelector:@selector(fileLoadingFailed:fromURL:)
                               withObject:error
                               withObject:[self url]];
        [self setFinished:YES];
        connection = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (![self cancelled]) {
        [self notifyObserversWithSelector:@selector(fileLoadingDidStartFromURL:)
                               withObject:[self url]
                               withObject:nil];
        expectedDataSize = [response expectedContentLength];
    }    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (![self cancelled]) {
        [receivedData appendData:data];
        float progress = [receivedData length] / (float)expectedDataSize;
        
        [self notifyObserversWithSelector:@selector(fileLoadingProgress:fromURL:)
                               withObject:[NSNumber numberWithFloat:progress]
                               withObject:[self url]];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    if (![self cancelled]) {
        [self notifyObserversWithSelector:@selector(fileLoaded:fromURL:)
                               withObject:receivedData
                               withObject:[self url]];
        [self setExecuting:NO];
        [self setFinished:YES];
        connection = nil;
        
        [[self filesCache] cacheFileData:receivedData forKey:[[self url] absoluteString]];
    }
}

#pragma mark -
#pragma mark notify

- (void) notifyObserversWithSelector:(SEL) selector withObject:(id) first withObject:(id) second
{
    @synchronized (self) {
        for (id<EKFilesLoaderDelegate> observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:first withObject:second];
            }
        }
    }
}

#pragma mark -
#pragma mark observers management

- (void) registerObserver:(id<EKFilesLoaderDelegate>) observer
{
    @synchronized (self) {
        if (![observers containsObject:observer] && observer != nil) {
            [observers addObject:observer];
        }
    }
}

- (void) removeObserver:(id<EKFilesLoaderDelegate>) observer
{
    @synchronized (self) {
        [observers removeObject:observer];
    }
}

- (void) removeObservers
{
    @synchronized (self) {
        [observers removeAllObjects];
    }
}

@end
