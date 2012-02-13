//
//  MockNSHTTPURLResponse.h
//
//  Created by William Fleming on 2/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockNSHTTPURLResponse : NSHTTPURLResponse

// setters for inherited attributes
- (void) setURL:(NSURL*)url;
- (void) setMIMEType:(NSString*)mimeType;
- (void) setSuggestedFilename:(NSString*)filename;
- (void) setExpectedContentLength:(NSInteger)contentLength;
- (void) setTextEncodingName:(NSString*)name;
- (void) setAllHeaderFields:(NSDictionary*)headerFields;
- (void) setStatusCode:(NSInteger)statusCode;

// new methods
- (NSData*) HTTPBody;
- (void) setHTTPBody:(NSData*)body;

@end
