# MockNSURLConnection

MockNSURLConnection mocks web requests to aid unit testing in ObjC projects. It works by swizzling instances of `MockNSURLConnection` in for instances of `NSURLConnection` whenever an `+[NSURLConnection alloc]` message is sent. In other words, this is a hack, but a useful one. Also, that means it *only* correctly works with code that relies on `NSURLConnection`: code that uses `CFNetwork` will be unaffected.

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
  [MockNSURLConnection stubResponseStatus:200
                                     body:@"woo"
                                   forURL:@"http://foo.bar/baz"];
  
  // so on and so forth, call your code/NSURLConnection like normal
}

@end
```