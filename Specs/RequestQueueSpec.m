//
//  RequestQueueSpec.m
//  JSONClient
//
//  Created by John Clayton on 9/16/2009.
//  Copyright 2009 Fivesquare Software, LLC. All rights reserved.
//

/* 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE. */

#import "RequestQueueSpec.h"


#define kRequestQueueSpecAsyncRequestTimeLimit 5

@implementation RequestQueueSpec

@synthesize specHelper;
@synthesize completedRequest;

+ (NSString *) description {
    return @"Queued Requests";
}

- (void) beforeAll {
    // set up resources common to all examples here
	self.specHelper = [[SpecHelper alloc] init];
}

- (void) beforeEach {
    // set up resources that need to be initialized before each example here 
    self.completedRequest = nil;
}

- (void) shouldReceiveDelegateCallbackOnCompletingAQueuedRequest {
	[NSThread detachNewThreadSelector:@selector(threadHelperForShouldReceiveDelegateCallbackOnCompletingAQueuedRequest) 
							 toTarget:self 
						   withObject:nil];

	NSDate *started = [NSDate date];
	while(completedRequest == nil) {
		NSDate *now = [NSDate date];
		if([now timeIntervalSinceDate:started] > kRequestQueueSpecAsyncRequestTimeLimit)
			break;
		sleep(1);
	}
	NSAssert([self.completedRequest.response isOk], @"Response should be ok");
}

- (void) threadHelperForShouldReceiveDelegateCallbackOnCompletingAQueuedRequest {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	// TODO: move this to an ivar so we can release it
	JSONClient *client = [[JSONClient alloc] init]; // yeah, we leak this
	client.delegate = self;
	[client queueGetRequest:[kTestServerHost stringByAppendingPathComponent:@"/test/item"] 
					headers:nil];
	[pool release];
}


- (void) afterEach {
    // tear down resources specific to each example here
}


- (void) afterAll {
    // tear down common resources here
	self.specHelper = nil;
}



- (void) client:(JSONClient *)client finishedQueuedRequest:(JSONRequest *)request {
	self.completedRequest = request;
}


@end
