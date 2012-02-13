//
//  MockNSHTTPURLResponse.m
//
//  Created by William Fleming on 2/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "MockNSHTTPURLResponse.h"

@implementation MockNSHTTPURLResponse {
  NSURL *m_url;
  NSString *m_mimeType;
  NSString *m_filename;
  NSInteger m_contentLength;
  NSString *m_textEncodingName;
  NSInteger m_statusCode;
  NSDictionary *m_headerFields;
  
  NSData *m_body;
}

- (id)initWithURL:(NSURL *)URL MIMEType:(NSString *)MIMEType expectedContentLength:(NSInteger)length textEncodingName:(NSString *)name {
  if ((self = [self init])) {
    m_url = URL;
    m_mimeType = MIMEType;
    m_contentLength = length;
    m_textEncodingName = name;
  }
  return self;
}

-(id)initWithURL:(NSURL*) url statusCode:(NSInteger) statusCode HTTPVersion:(NSString*) HTTPVersion headerFields:(NSDictionary*) headerFields {
  if ((self = [self init])) {
    m_url = url;
    m_statusCode = statusCode;
    m_headerFields = headerFields;
  }
  return self;
}

- (id) init {
  if (nil != self) {
    m_contentLength = -1;
    m_statusCode = 200;
  }
  return self;
}

- (NSURL*) URL {
  return m_url;
}

- (void) setURL:(NSURL*)url {
  m_url = url;
}

- (NSString*) MIMEType {
  return m_mimeType;
}

- (void) setMIMEType:(NSString*)mimeType {
  m_mimeType = mimeType;
}

- (NSString*) suggestedFilename {
  return m_filename;
}

- (void) setSuggestedFilename:(NSString*)filename {
  m_filename = filename;
}

- (long long) expectedContentLength {
  return m_contentLength;
}

- (void) setExpectedContentLength:(NSInteger)contentLength {
  m_contentLength = contentLength;
}

- (NSString*) textEncodingName {
  return m_textEncodingName;
}

- (void) setTextEncodingName:(NSString*)name {
  m_textEncodingName = name;
}

- (NSDictionary *)allHeaderFields {
  return m_headerFields;
}

- (void) setAllHeaderFields:(NSDictionary*)headerFields {
  m_headerFields = headerFields;
}

- (NSInteger) statusCode {
  return m_statusCode;
}

- (void) setStatusCode:(NSInteger)statusCode {
  m_statusCode = statusCode;
}

- (NSData*) HTTPBody {
  return m_body;
}

- (void) setHTTPBody:(NSData*)body {
  m_body = body;
}

@end
