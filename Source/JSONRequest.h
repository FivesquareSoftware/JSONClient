//
//  JSONRequest.h
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

@class JSONRequest;

@protocol JSONRequestDelegate <NSObject>
@optional
- (void) requestDidFinish:(JSONRequest *)request;
@end



@class JSONResponse;

@interface JSONRequest : NSOperation {
	id<JSONRequestDelegate> delegate;
	
	NSURLRequest *urlRequest;
	NSURLCredential *credentials;
	
	JSONResponse *response;
}

@property (nonatomic, retain) id<JSONRequestDelegate> delegate;
@property (nonatomic, retain) NSURLRequest *urlRequest;
@property (nonatomic, retain) NSURLCredential *credentials;
@property (nonatomic, readonly) JSONResponse *response;


- (id) initWithURLRequest:(NSURLRequest *)aURLRequest;



@end
