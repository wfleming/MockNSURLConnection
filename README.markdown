# MockNSURLConnection

MockNSURLConnection is a library for mocking web requests in ObjC projects. It works by swizzling instances of `MockNSURLConnection` in for instances of `NSURLConnection` whenever an `+[NSURLConnection alloc]` message is sent. In other words, this is a hack, and likely to be delicate (I've already found it can confuse ARC in some cases).

## Use

```objc
#import "MockNSURLConnection.h"

@implementation YourAwesomeTests

- (void)setUp
{
  [super setUp];
    
  [MockNSURLConnection beginStubbing];
}

- (void)tearDown
{
  [MockNSURLConnection stopStubbing];
  
  [super tearDown];
}

- (void)testYourAwesomeThing
{
  [MockNSURLConnection stubResponseStatus:200 body:@"woo" forURL:@"http://foo.bar/baz"];
  
  // so on and so forth
}

@end
```