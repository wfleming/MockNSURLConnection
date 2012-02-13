//
//  TestConnectionDelegate.h
//  MockNSURLConnection
//
//  Created by William Fleming on 2/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestConnectionDelegate : NSObject

@property (strong, nonatomic) NSURLResponse *receivedResponse;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (assign, nonatomic) BOOL connectionCompleted;

@property (strong, nonatomic) NSData *expectedBody;
@property (assign, nonatomic) NSInteger expectedStatus;

@end
