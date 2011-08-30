//
//  AuthSpec.m
//  JSONClient
//
//  Created by John Clayton on 9/11/2009.
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

#import "AuthSpec.h"


@implementation AuthSpec

@synthesize specHelper;

+ (NSString *) description {
    return @"BASIC Auth Handling";
}

- (void) beforeAll {
    // set up resources common to all examples here
	self.specHelper = [[SpecHelper alloc] init];
}

- (void) beforeEach {
    // set up resources that need to be initialized before each example here 
}

- (void) shouldBeUnauthorized {
	JSONClient *client = [[[JSONClient alloc] init] autorelease];
	JSONResponse *response = [client get:[kTestServerHost stringByAppendingPathComponent:@"/test/protected"]];
	NSLog(@"response.result: %@",response.result);
	NSLog(@"response.error: %@",response.error);
	NSAssert([response isUnauthorized], @"Response should be unauthorized");
}

- (void) shouldFailAuthorizationWithBadCredentials {
	JSONClient *client = [[[JSONClient alloc] init] autorelease];
	client.username = @"foo";
	client.password = @"bar";
	
	JSONResponse *response = [client get:[kTestServerHost stringByAppendingPathComponent:@"/test/protected"]];
	NSAssert([response isUnauthorized], @"Response should be unauthorized");
}

- (void) shouldBeAuthorized {
	JSONClient *client = [[[JSONClient alloc] init] autorelease];
	client.username = @"test";
	client.password = @"test";
	
	JSONResponse *response = [client get:[kTestServerHost stringByAppendingPathComponent:@"/test/protected"]];
	NSAssert([response isOk], @"Response should be ok");
}


- (void) afterEach {
    // tear down resources specific to each example here
}


- (void) afterAll {
    // tear down common resources here
	self.specHelper = nil;
}

@end
