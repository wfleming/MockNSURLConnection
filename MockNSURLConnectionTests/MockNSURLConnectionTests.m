//
//  MockNSURLConnectionTests.m
//  MockNSURLConnectionTests
//
//  Created by William Fleming on 2/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "MockNSURLConnectionTests.h"

#import "MockNSURLConnection.h"
#import "TestConnectionDelegate.h"

@implementation MockNSURLConnectionTests {
  TestConnectionDelegate *delegate;
  NSString *body, *url;
  NSInteger status;
  NSURLRequest *request;
  
  NSURLConnection *conn;
}

- (void)setUp
{
  [super setUp];
    
  [MockNSURLConnection beginStubbing];
  
  status = 200;
  body = @"foo";
  url = @"http://foo.bar/blah";
  
  delegate = [[TestConnectionDelegate alloc] init];
  delegate.expectedStatus = 200;
  delegate.expectedBody = [body dataUsingEncoding:NSUTF8StringEncoding];
  
  request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}

- (void)tearDown
{
  [MockNSURLConnection stopStubbing];
  
  status = 0;
  body = nil;
  url = nil;
  delegate = nil;
  
  // conn seems to be having some odd issue with ARC:
  // when test local, it always zombies before ARC thinks it's been dealloced.
  // can't nil it out explicitly here either, or the same happens.
  // not sure...haven't seen anything like this with earlier tests in use.
  
  [super tearDown];
}

- (void) verifyDelegate {
  if ([delegate.receivedResponse isKindOfClass:[NSHTTPURLResponse class]]) {
    STAssertEquals(delegate.expectedStatus, [(NSHTTPURLResponse*)delegate.receivedResponse statusCode], nil);
  }
  STAssertEqualObjects(delegate.expectedBody, delegate.receivedData, nil);
  STAssertTrue(delegate.connectionCompleted, nil);
}

- (void)test_StubResponseCode_body_forURL
{
  [MockNSURLConnection stubResponseStatus:status body:body forURL:url];
  
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:YES];
  [self verifyDelegate];
}

- (void)test_StubResponseCode_bodyData_forURL
{
  [MockNSURLConnection stubResponseStatus:status
                                 bodyData:[body dataUsingEncoding:NSUTF8StringEncoding]
                                   forURL:url];
  
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:YES];
  
  [self verifyDelegate];
}

- (void)test_StubResponse_forURL
{
  MockNSHTTPURLResponse *r = [[MockNSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:url] 
                                                               MIMEType:@"text/html"
                                                  expectedContentLength:3
                                                       textEncodingName:@"UTF8"];
  [r setStatusCode:status];
  [r setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
  [MockNSURLConnection stubResponse:r forURL:url];
  
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:YES];
  
  [self verifyDelegate];
}

- (void) testNoStartImmediately
{
  [MockNSURLConnection stubResponseStatus:status body:body forURL:url];
  
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:NO];
  
  STAssertFalse(delegate.connectionCompleted, nil);
  
  [conn start];
  
  [self verifyDelegate];
}

- (void) testExceptionWhenNoStub {
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:NO];
  
  STAssertThrowsSpecific([conn start], UnexpectedStubURLRequestException, nil);
}

- (void) testMockKindOf {
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:NO];
  
  STAssertTrue([conn class] == [MockNSURLConnection class], nil);
  STAssertTrue([conn isKindOfClass:[NSURLConnection class]], nil);
}

- (void) testMockMemberOf {
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:NO];
  STAssertTrue([conn class] == [MockNSURLConnection class], nil);
  STAssertTrue([conn isMemberOfClass:[NSURLConnection class]], nil);
}

- (void) testTurningStubbingOff {
  [MockNSURLConnection stopStubbing];
  
  conn = [[NSURLConnection alloc] initWithRequest:request
                                         delegate:delegate
                                 startImmediately:NO];
  
  STAssertTrue([conn class] == [NSURLConnection class], nil);
}

@end
