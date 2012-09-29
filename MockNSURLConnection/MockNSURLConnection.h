//
//  MockNSURLConnection.h
//
//  Created by William Fleming on 2/11/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MockNSHTTPURLResponse.h"


@interface UnexpectedStubURLRequestException : NSException


- (id) initWithURL:(NSString*)url;
+ (void) raiseForURL:(NSString*)url;

@end

/**
 * A stubbing proxy of NSURLConnection.
 *
 * Ensures that no real HTTP behavior happens during tests.
 * Throws an exception when an unexpected request comes through.
 *
 * Note this *only* intercepts and prevents HTTP traffic via
 * NSURLConnection. Anything using CF, etc. will be unaffected.
 */
@interface MockNSURLConnection : NSObject

/**
 * begin mocking - after calling this,
 * +[NSURLConnection alloc] will return instances of
 * MockNSURLConnection.
 */
+ (void) beginStubbing;

/**
 * Stop mocking. NSURLConnection should go back to behaving as normal.
 */
+ (void) stopStubbing;

/**
 * Stub out a response to receive for a given URL.
 */
+ (void) stubResponse:(MockNSHTTPURLResponse*)response forURL:(NSString*)requestURL;
+ (void) stubResponseStatus:(NSInteger)statusCode body:(NSString*)body forURL:(NSString*)requestURL;
+ (void) stubResponseStatus:(NSInteger)statusCode bodyData:(NSData*)body forURL:(NSString*)requestURL;


#pragma mark - NSURLConnection public interface

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately;
- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate;

+ (NSURLConnection*)connectionWithRequest:(NSURLRequest *)request delegate:(id)delegate;

- (NSURLRequest *)originalRequest;
- (NSURLRequest *)currentRequest;

- (void)start;
- (void)cancel;

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;
- (void)unscheduleFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;
- (void)setDelegateQueue:(NSOperationQueue*) queue;


@end
