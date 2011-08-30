//
//  JSONClient.h
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

#import <Foundation/Foundation.h>

#import "JSONRequest.h"
#import "JSONResponse.h"

@class JSONClient;
@protocol JSONClientDelegate <NSObject>
@optional
- (void) client:(JSONClient *)client finishedQueuedRequest:(JSONRequest *)request;
@end


@interface JSONClient : NSObject <JSONRequestDelegate> {
	id<JSONClientDelegate> delegate;
	
	NSString *username;
	NSString *password;
	
	NSOperationQueue *requestQueue;
}

@property (nonatomic, assign) id<JSONClientDelegate> delegate;
@property (nonatomic, copy) NSString *username; 
@property (nonatomic, copy) NSString *password; 
@property (nonatomic, readonly) NSOperationQueue *requestQueue;


- (void) queueGetRequest:(NSString *)urlString headers:(NSDictionary *)headers;
- (void) queuePutRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers;
- (void) queuePostRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers;
- (void) queueDeleteRequest:(NSString *)urlString headers:(NSDictionary *)headers;
- (void) queueHeadRequest:(NSString *)urlString headers:(NSDictionary *)headers;

- (JSONResponse *) get:(NSString *)urlString;
- (JSONResponse *) put:(NSString *)urlString payload:(id)payload;
- (JSONResponse *) post:(NSString *)urlString payload:(id)payload;
- (JSONResponse *) delete:(NSString *)urlString;
- (JSONResponse *) head:(NSString *)urlString;

- (JSONResponse *) get:(NSString *)urlString headers:(NSDictionary *)headers;
- (JSONResponse *) put:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers;
- (JSONResponse *) post:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers;
- (JSONResponse *) delete:(NSString *)urlString headers:(NSDictionary *)headers;
- (JSONResponse *) head:(NSString *)urlString headers:(NSDictionary *)headers;

- (JSONRequest *) getRequest:(NSString *)urlString headers:(NSDictionary *)headers;
- (JSONRequest *) putRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers;
- (JSONRequest *) postRequest:(NSString *)urlString payload:(id)payload headers:(NSDictionary *)headers;
- (JSONRequest *) headRequest:(NSString *)urlString headers:(NSDictionary *)headers;
- (JSONRequest *) deleteRequest:(NSString *)urlString headers:(NSDictionary *)headers;


@end
