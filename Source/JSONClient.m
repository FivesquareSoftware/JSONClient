//
//  JSONClient.m
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


#import "JSONClient.h"


#import "NSDataAdditions.h"
#import "SBJsonWriter.h"


static NSString *kJSONClientHTTPMethodGET = @"GET";
static NSString *kJSONClientHTTPMethodPOST = @"POST";
static NSString *kJSONClientHTTPMethodPUT = @"PUT";
static NSString *kJSONClientHTTPMethodDELETE = @"DELETE";
static NSString *kJSONClientHTTPMethodHEAD = @"HEAD";


@interface JSONClient ()
- (NSMutableURLRequest *) URLRequestForUrlString:(NSString *)urlString;
- (void) addAuthHeader:(NSMutableURLRequest *)urlRequest;
- (NSString *) encodedCredentials;
- (NSData *) JSONPayload:(id)value;
@end




@implementation JSONClient


// ========================================================================== //

#pragma mark -
#pragma mark Properties


@synthesize delegate, username, password;
@dynamic requestQueue;


- (NSOperationQueue *) requestQueue {
	if(requestQueue == nil) {
		requestQueue = [[NSOperationQueue alloc] init];
	}
	return requestQueue;
}


// ========================================================================== //

#pragma mark -
#pragma mark Object



- (void) dealloc {
	delegate = nil;
	[username release];
	[password release];
	[super dealloc];
}



// ========================================================================== //

#pragma mark -
#pragma mark Requestors



#pragma mark --Simple


- (JSONResponse *) get:(NSString *)urlString {
	return [self get:urlString headers:nil];
}

- (JSONResponse *) put:(NSString *)urlString payload:(id)payload {
	return [self put:urlString payload:payload headers:nil];
}

- (JSONResponse *) post:(NSString *)urlString payload:(id)payload {
	return [self post:urlString payload:payload headers:nil];
}

- (JSONResponse *) delete:(NSString *)urlString {
	return [self delete:urlString headers:nil];
}

- (JSONResponse *) head:(NSString *)urlString {
	return [self head:urlString headers:nil];
}



#pragma mark --Queued


- (void) queueGetRequest:(NSString *)urlString headers:(NSDictionary *)headers {
	JSONRequest *request = [self getRequest:urlString headers:headers];
	request.delegate = self;
	[self.requestQueue addOperation:request];
}

- (void) queuePutRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers {
	JSONRequest *request = [self putRequest:urlString payload:payload headers:headers];
	request.delegate = self;
	[self.requestQueue addOperation:request];
}

- (void) queuePostRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers {
	JSONRequest *request = [self postRequest:urlString payload:payload headers:headers];
	request.delegate = self;
	[self.requestQueue addOperation:request];
}

- (void) queueDeleteRequest:(NSString *)urlString headers:(NSDictionary *)headers {
	JSONRequest *request = [self headRequest:urlString headers:headers];
	request.delegate = self;
	[self.requestQueue addOperation:request];
}

- (void) queueHeadRequest:(NSString *)urlString headers:(NSDictionary *)headers {
	JSONRequest *request = [self deleteRequest:urlString headers:headers];
	request.delegate = self;
	[self.requestQueue addOperation:request];
}



#pragma mark --Complex


- (JSONResponse *) get:(NSString *)urlString headers:(NSDictionary *)headers {
	JSONRequest *request = [self getRequest:urlString headers:headers];

	[request start];
	
	JSONResponse *response = [[request.response retain] autorelease];
	return response;
}

- (JSONResponse *) put:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers {
	JSONRequest *request = [self putRequest:urlString payload:payload headers:headers];

	[request start];

	JSONResponse *response = [[request.response retain] autorelease];
	return response;
}

- (JSONResponse *) post:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers {
	JSONRequest *request = [self postRequest:urlString payload:payload headers:headers];
	[request start];
	
	JSONResponse *response = [[request.response retain] autorelease];
	return response;
}

- (JSONResponse *) head:(NSString *)urlString headers:(NSDictionary *)headers {
	JSONRequest *request = [self headRequest:urlString headers:headers];
	[request start];
	
	JSONResponse *response = [[request.response retain] autorelease];
	return response;
}

- (JSONResponse *) delete:(NSString *)urlString headers:(NSDictionary *)headers {
	JSONRequest *request = [self deleteRequest:urlString headers:headers];
	[request start];
	
	JSONResponse *response = [[request.response retain] autorelease];
	return response;
}





// ========================================================================== //

#pragma mark -
#pragma mark Request Constructors



- (JSONRequest *) getRequest:(NSString *)urlString headers:(NSDictionary *)headers {
	NSMutableURLRequest *urlRequest = [self URLRequestForUrlString:urlString];
	[urlRequest setHTTPMethod:kJSONClientHTTPMethodGET];
	for (NSString *name in headers) {
		[urlRequest addValue:[headers objectForKey:name] forHTTPHeaderField:name];
	}

	return [[[JSONRequest alloc] initWithURLRequest:urlRequest] autorelease];
}

- (JSONRequest *) putRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers {
	NSMutableURLRequest *urlRequest = [self URLRequestForUrlString:urlString];
	[urlRequest setHTTPMethod:kJSONClientHTTPMethodPUT];
	[urlRequest setHTTPBody:[self JSONPayload:payload]];
	for (NSString *name in headers) {
		[urlRequest addValue:[headers objectForKey:name] forHTTPHeaderField:name];
	}
	
	return [[[JSONRequest alloc] initWithURLRequest:urlRequest] autorelease];
}

- (JSONRequest *) postRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers {
	NSMutableURLRequest *urlRequest = [self URLRequestForUrlString:urlString];
	[urlRequest setHTTPMethod:kJSONClientHTTPMethodPOST];
	[urlRequest setHTTPBody:[self JSONPayload:payload]];
	for (NSString *name in headers) {
		[urlRequest addValue:[headers objectForKey:name] forHTTPHeaderField:name];
	}
	
	return [[[JSONRequest alloc] initWithURLRequest:urlRequest] autorelease];
}

- (JSONRequest *) headRequest:(NSString *)urlString headers:(NSDictionary *)headers {
	NSMutableURLRequest *urlRequest = [self URLRequestForUrlString:urlString];
	[urlRequest setHTTPMethod:kJSONClientHTTPMethodHEAD];
	for (NSString *name in headers) {
		[urlRequest addValue:[headers objectForKey:name] forHTTPHeaderField:name];
	}
	
	return [[[JSONRequest alloc] initWithURLRequest:urlRequest] autorelease];
}

- (JSONRequest *) deleteRequest:(NSString *)urlString headers:(NSDictionary *)headers {
	NSMutableURLRequest *urlRequest = [self URLRequestForUrlString:urlString];
	[urlRequest setHTTPMethod:kJSONClientHTTPMethodDELETE];
	for (NSString *name in headers) {
		[urlRequest addValue:[headers objectForKey:name] forHTTPHeaderField:name];
	}
	
	return [[[JSONRequest alloc] initWithURLRequest:urlRequest] autorelease];
}



// ========================================================================== //

#pragma mark -
#pragma mark Helpers


- (NSMutableURLRequest *) URLRequestForUrlString:(NSString *)urlString {
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]] autorelease];
	[self addAuthHeader:urlRequest];
	[urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	return urlRequest;
}

- (void) addAuthHeader:(NSMutableURLRequest *)urlRequest {
	NSString *encodedCredentials = [self encodedCredentials];
	if(encodedCredentials) {
		[urlRequest addValue:encodedCredentials forHTTPHeaderField:@"Authorization"];
	}
}

- (NSString *) encodedCredentials {
	NSString *encoded = nil;
	if(self.username && [self.username length] > 0
	   && self.password && [self.password length] > 0) {
		NSString *string = [NSString stringWithFormat:@"%@:%@",self.username,self.password];
		NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
		NSString *base64String = [stringData base64Encoding];
		encoded = [NSString stringWithFormat:@"Basic %@",base64String];
	}
	return encoded;
}

- (NSData *) JSONPayload:(id)value {
	SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
	NSString *jsonString = [jsonWriter stringWithObject:value];
	NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	[jsonWriter release];
	return jsonData;
}



// ========================================================================== //

#pragma mark -
#pragma mark JSONRequestDelegate

- (void) requestDidFinish:(JSONRequest *)request {
	if([self.delegate respondsToSelector:@selector(client:finishedQueuedRequest:)]) {
		[self.delegate client:self finishedQueuedRequest:request];
	}
}



@end
