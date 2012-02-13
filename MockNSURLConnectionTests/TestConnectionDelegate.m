//
//  TestConnectionDelegate.m
//  MockNSURLConnection
//
//  Created by William Fleming on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestConnectionDelegate.h"

#import <SenTestingKit/SenTestingKit.h>

@implementation TestConnectionDelegate

@synthesize receivedResponse, receivedData, connectionCompleted;
@synthesize expectedBody, expectedStatus;


// delegate methods we expect to be called: used for verification
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse {
	self.receivedResponse = aResponse;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData {
  if (nil == self.receivedData) {
    self.receivedData = [[NSMutableData alloc] init];
  }
  [self.receivedData appendData:someData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	self.connectionCompleted = YES;
}

// delegate methods that should never be called with current capabilities, but here for completeness
- (NSURLRequest *)connection:(NSURLConnection *)aConnection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
	return request;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  return;
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
  return NO;
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  return;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  return;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
  return NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  return;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)aConnection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
	return nil;
}

@end
