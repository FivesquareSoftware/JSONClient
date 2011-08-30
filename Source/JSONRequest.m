//
//  JSONRequest.m
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

#import "JSONRequest.h"

#import "JSONResponse.h"
#import "SBJsonParser.h"


@implementation JSONRequest


// ========================================================================== //

#pragma mark -
#pragma mark Properties


@synthesize delegate;
@synthesize urlRequest;
@synthesize credentials;
@synthesize response;



// ========================================================================== //

#pragma mark -
#pragma mark Object



- (void) dealloc {
	delegate = nil;
	[credentials release];
	[response release];
	[super dealloc];
}


- (id) initWithURLRequest:(NSURLRequest *)aURLRequest {
	self = [super init];
	if (self != nil) {
		urlRequest = [aURLRequest retain];
	}
	return self;
}


// ========================================================================== //

#pragma mark -
#pragma mark NSOperation


- (void) main {
	NSError *error = nil;
	NSHTTPURLResponse *urlResponse;

#ifdef DEBUG
	NSLog(@"%@",[self.urlRequest description]);
#endif
	NSData *responseData = [NSURLConnection sendSynchronousRequest:self.urlRequest returningResponse:&urlResponse error:&error];
	
	response = [[JSONResponse alloc] init];
	response.urlRequest = self.urlRequest;
	if(error) {
		response.error = error;
		if([error domain] == NSURLErrorDomain) {
			switch ([error code]) {
				case NSURLErrorUserCancelledAuthentication:
					response.status = 401;
					break;
				default:
					break;
			}
		}
	} else {
		response.status = [urlResponse statusCode];
		response.headers = [urlResponse allHeaderFields];
	}
	
	NSString *jsonString = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
	response.body = jsonString;
	@try {
		SBJsonParser *parser = [SBJsonParser new];
		id result = [parser objectWithString:jsonString];
		if (!result) {
			NSLog(@"Error trace: %@", parser.errorTrace);
			NSLog(@"Raw string: %@",jsonString);
		} else {
			response.result = result;
		}
	}
	@catch (NSException * e) {
		NSLog(@"Error parsing JSON response %@ (%@)",error,[error userInfo]);
	}

	[jsonString release];

	if([self.delegate respondsToSelector:@selector(requestDidFinish:)]) {
		[self.delegate requestDidFinish:self];
	}
}




@end
