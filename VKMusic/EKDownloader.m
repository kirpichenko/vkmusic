//
//  FileLoadingOperation.m
//  ImageLoaderTest
//
//  Created by Evgeniy Kirpichenko on 1/17/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import "EKDownloader.h"

@interface EKDownloader ()
@property (nonatomic, readwrite) BOOL executing;
@property (nonatomic, readwrite) BOOL finished;
@property (nonatomic, readwrite) BOOL cancelled;

@property (nonatomic, strong, readwrite) NSURL *url;
@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, strong) id<EKFilesCache> filesCache;
@end

@implementation EKDownloader

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

    [self setUrl:nil];
    [self setFilesCache:nil];
    [self setConnection:nil];
    
    [super dealloc];
}

#pragma mark -
#pragma mark connection

- (void) createConnectionWithURL:(NSURL *) url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self
                                                          startImmediately:NO];
    [self setConnection:connection];
}

#pragma mark -
#pragma mark loading

- (void) start
{
    if (![self executing]) {
        if (![self cancelled]) {
            [self notifyObserversWithSelector:@selector(downloadingWillStart:)];
            [self createConnectionWithURL:[self url]];

            [self setExecuting:YES];            
            [[self connection] start];
        }
    }
    else {
        NSLog(@"Loading already in progress");
    }
}

- (void) cancel
{
    [self setCancelled:YES];
    [self setExecuting:NO];
    
    [[self connection] cancel];
    [self notifyObserversWithSelector:@selector(downloadingCancelled:)];
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error
{
    if (![self cancelled]) {
        [self setError:error];
        [self setFinished:YES];
        [self setConnection:nil];
        
        [self notifyObserversWithSelector:@selector(downloadingFailed:)];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (![self cancelled]) {
        [self notifyObserversWithSelector:@selector(downloadingStarted:)];

        expectedDataSize = [response expectedContentLength];
    }    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (![self cancelled]) {
        [receivedData appendData:data];
        
        float progress = [receivedData length] / (float)expectedDataSize;
        [self notifyObserversWithProgress:progress];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    if (![self cancelled]) {
        [self setExecuting:NO];
        [self setFinished:YES];

        [self setConnection:nil];
        [self setResponse:receivedData];
        
        [[self filesCache] cacheFileData:receivedData forKey:[[self url] absoluteString]];
        [self notifyObserversWithSelector:@selector(downloadingFinished:)];
    }
}

#pragma mark -
#pragma mark notify

- (void) notifyObserversWithSelector:(SEL) selector
{
    @synchronized (self) {
        for (id<EKDownloaderDelegate> observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:self];
            }
        }
    }
}

- (void) notifyObserversWithProgress:(NSInteger) progress
{
    @synchronized (self) {
        for (id<EKDownloaderDelegate> observer in observers) {
            if ([observer respondsToSelector:@selector(downloading:inProgress:)]) {
                [observer downloading:self inProgress:progress];
            }
        }
    }
}

#pragma mark -
#pragma mark observers management

- (void) registerObserver:(id<EKDownloaderDelegate>) observer
{
    @synchronized (self) {
        if (![observers containsObject:observer] && observer != nil) {
            [observers addObject:observer];
        }
    }
}

- (void) removeObserver:(id<EKDownloaderDelegate>) observer
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
