//
//  JSONResponse.m
//  JSONClient
//
//  Created by John Clayton on 9/6/2009.
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

#import "JSONResponse.h"


@implementation JSONResponse


// ========================================================================== //

#pragma mark -
#pragma mark Properties


@synthesize urlRequest, status, headers, body, result, error;



// ========================================================================== //

#pragma mark -
#pragma mark Object



- (void) dealloc {
	[urlRequest release];
	[headers release];
	[body release];
	[result release];
	[error release];
	
	[super dealloc];
}


- (NSString *) description {
	return [NSString stringWithFormat:@"%@ (%@, %d, %@, %@, %@, %@)"
			,[super description]
			, [urlRequest description]
			, status
			, [headers description]
			, body
			, result
			, error
	];
}

// ========================================================================== //

#pragma mark -
#pragma mark Status Codes



- (BOOL) isOk {
	return self.status == 200;
}

- (BOOL) isCreated {
	return self.status == 201;
}

- (BOOL) isFound {
	return self.status == 302;
}

- (BOOL) isUnauthorized {
	return self.status == 401;
}

- (BOOL) isForbidden {
	return self.status == 403;
}

- (BOOL) isNotFound {
	return self.status == 404;
}

- (BOOL) isUnprocessableEntity {
	return self.status == 422;
}



// ========================================================================== //

#pragma mark -
#pragma mark Status Ranges


- (BOOL) wasSuccessful {
	return self.status >= 200 && self.status < 300;
}

- (BOOL) wasRedirect {
	return self.status >= 300 && self.status < 400;
}

- (BOOL) wasClientErrror {
	return self.status >= 400 && self.status < 500;
}

- (BOOL) wasServerError {
	return self.status >= 500 && self.status < 600;
}

@end
