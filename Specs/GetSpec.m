//
//  SpecRunnerSpec.m
//  WholeFoods
//
//  Created by John Clayton on 12/23/2008.
//  Copyright 2008 Fivesquare Software, LLC. All rights reserved.
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

#import "GetSpec.h"


@implementation GetSpec

@synthesize specHelper;

+ (NSString *) description {
    return @"Get Requests";
}

- (void) beforeAll {
	self.specHelper = [[SpecHelper alloc] init];
}

- (void) beforeEach {
}

- (void) shouldGetAnItemCorrectly {
	JSONClient *client = [[[JSONClient alloc] init] autorelease];
	JSONResponse *response = [client get:[kTestServerHost stringByAppendingPathComponent:@"/test/item"]];
	NSAssert([response isOk], @"Response should be ok");
	NSAssert([response.result isEqualToDictionary:[self.specHelper item]], @"Result did not equal item");
}

- (void) shouldGetAListCorrectly {
	JSONClient *client = [[[JSONClient alloc] init] autorelease];
	JSONResponse *response = [client get:[kTestServerHost stringByAppendingPathComponent:@"/test/list"]];
	NSAssert([response isOk], @"Response should be ok");
	NSAssert([response.result isEqualToArray:[self.specHelper list]], @"Result did not equal list");
}

- (void) afterEach {
}

- (void) afterAll {
	self.specHelper = nil;
}

@end
