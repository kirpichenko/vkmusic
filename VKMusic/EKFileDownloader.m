//
//  FileLoadingOperation.m
//  ImageLoaderTest
//
//  Created by Evgeniy Kirpichenko on 1/17/12.
//  Copyright (c) 2012 MLS. All rights reserved.
//

#import "EKFileDownloader.h"
#import "EKFileDownloaderDelegate.h"

static NSString *const kFinishedState = @"isFinished";
static NSString *const kExecutingState = @"isExecuting";

@interface EKFileDownloader ()
@property (nonatomic,assign) BOOL finished;
@property (nonatomic,assign) BOOL executing;

@property (nonatomic,retain,readwrite) NSURL *url;
@property (nonatomic,retain,readwrite) NSData *response;
@property (nonatomic,retain,readwrite) NSError *error;
@end

@implementation EKFileDownloader

#pragma mark -
#pragma mark life cycle

- (id) initWithURL:(NSURL *) url
{
    if (self = [super init]) {
        observers = [[NSMutableArray alloc] init];
        receivedData = [[NSMutableData alloc] init];
        
        [self setUrl:url];
    }
    return self;
}

- (id) init
{
    [NSException raise:@"Exception:"
                format:@"Use initWithUrl:, initWithURL:filesCache: methods to create loader"];
    return nil;
}

- (void) dealloc
{
    NSLog(@"operation deleted");
    [observers release];
    [receivedData release];

    [self setUrl:nil];
    [self setResponse:nil];
    [self setError:nil];

    [self cancelConnection];
    
    [super dealloc];
}

#pragma mark -
#pragma mark instance methods

- (void) start
{
    [self willChangeValueForKey:kExecutingState];

    [self notifyObserversWithSelector:@selector(downloadingWillStart:)];
    [self createConnection];
    
    [self setExecuting:YES];
    
    [self didChangeValueForKey:kExecutingState];
}

- (void) cancel
{
    [self stopDownloading];
    [self notifyObserversWithSelector:@selector(downloadingCancelled:)];

    [super cancel];
}

- (void) stopDownloading
{
    [self willChangeValueForKey:kExecutingState];
    [self willChangeValueForKey:kFinishedState];
    
    [self cancelConnection];
    
    [self setFinished:YES];
    [self setExecuting:NO];
    
    [self didChangeValueForKey:kExecutingState];
    [self didChangeValueForKey:kFinishedState];
}

#pragma mark -
#pragma mark connection management

- (void) createConnection
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[self url]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [connection start];
}

- (void) cancelConnection
{
    [connection cancel];
    [connection release]; connection = nil;
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error
{
    if (![self isCancelled]) {
        [self setError:error];
        [self stopDownloading];
        
        [self notifyObserversWithSelector:@selector(downloadingFailed:)];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (![self isCancelled]) {
        expectedDataSize = [response expectedContentLength];
        
        [self notifyObserversWithSelector:@selector(downloadingStarted:)];
    }    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (![self isCancelled]) {
        [receivedData appendData:data];
        
        float progress = [receivedData length] / (float)expectedDataSize;
        [self notifyObserversWithProgress:progress];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    if (![self isCancelled]) {
        [self setResponse:receivedData];
        [self stopDownloading];
        
        [self notifyObserversWithSelector:@selector(downloadingFinished:)];
    }
}

#pragma mark -
#pragma mark notify

- (void) notifyObserversWithSelector:(SEL) selector
{
    @synchronized (self) {
        for (id<EKFileDownloaderDelegate> observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:self];
            }
        }
    }
}

- (void) notifyObserversWithProgress:(float) progress
{
    @synchronized (self) {
        for (id<EKFileDownloaderDelegate> observer in observers) {
            if ([observer respondsToSelector:@selector(downloading:inProgress:)]) {
                [observer downloading:self inProgress:progress];
            }
        }
    }
}

#pragma mark -
#pragma mark observers management

- (void) registerObserver:(id<EKFileDownloaderDelegate>) observer
{
    @synchronized (self) {
        if (![observers containsObject:observer] && observer != nil) {
            [observers addObject:observer];
        }
    }
}

- (void) removeObserver:(id<EKFileDownloaderDelegate>) observer
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
