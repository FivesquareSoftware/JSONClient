//
//  SpecHelper.m
//  JSONClient
//
//  Created by John Clayton on 9/10/2009.
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


#import "SpecHelper.h"

NSString *kTestServerHost = @"http://localhost:4567";

@implementation SpecHelper

- (NSDictionary *) itemDictionary {
	return [NSDictionary dictionaryWithObjectsAndKeys:
			 @"97cf53ebf930b5c6a134edfa0b90eb72b2edc38b", @"udid"
			, @"jPhone", @"alias"
			, @"CBADEBDEEFBECEDCFCFADFBCEBBFFECACCEFABECFDFCBAFCDEBFFAFCDBFCFDBF", @"token"
			, @"01 161200 615390 1", @"imei"
			, @"verizon", @"network"
			, @"87831LUY7K", @"serial_number"
			, [NSNumber numberWithInteger:10], @"version"
			, [self applicationsArray], @"applications"
			, @"2009-09-07T09:47:19Z"/*[self lastUpdatedDate]*/, @"last_updated"
			,nil];
}

- (NSArray *) applicationsArray {
	return [NSArray arrayWithObjects:[self applicationDictionary],[self applicationDictionary],nil];
}

- (NSDictionary *) applicationDictionary {
	return [NSDictionary dictionaryWithObject:@"MyApp" forKey:@"name"];
}

- (NSDate *) lastUpdatedDate {
	NSDate *date = [[self ISO8601DateFormatter] dateFromString:@"2009-09-07T09:47:19Z"];
	return date;
}

- (NSDictionary *) item {
	return [NSDictionary dictionaryWithObject:[self itemDictionary] forKey:@"device"];
}
			
- (NSArray *) list {
	NSMutableArray *listArray = [NSMutableArray array];
	for (int i = 0; i < 5; i++) {
		[listArray addObject:[self itemDictionary]];
	}
	return listArray;
}

- (NSDictionary *) listDictionary {
	return [NSDictionary dictionaryWithObject:[self list] forKey:@"list"];
}

- (NSDateFormatter *) ISO8601DateFormatter {
	static NSDateFormatter *ISO8601DateFormatter = nil;
	if(ISO8601DateFormatter == nil) {
		ISO8601DateFormatter = [[NSDateFormatter alloc] init];
		[ISO8601DateFormatter setDateFormat:@"yyyy-mm-dd'T'HH:MM:SS'Z'"];
		[ISO8601DateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	}
	return ISO8601DateFormatter;
}


@end



/*
def item
{
	:device => {
		:udid => '97cf53ebf930b5c6a134edfa0b90eb72b2edc38b', 
		:alias => 'jPhone', 
		:token => 'CBADEBDEEFBECEDCFCFADFBCEBBFFECACCEFABECFDFCBAFCDEBFFAFCDBFCFDBF',
		:imei => '01 161200 615390 1',
		:network => 'verizon',
		:serial_number => '87831LUY7K',
		:version => 10,
		:applications => [{:name => 'app1'},{:name => 'app2'}],
		:last_updated => '2009-09-07T09:47:19-07:00'
	}
	}
	end
	
	def list(count=5)		
	items = (1..count).collect {
		self.item[:device]
	}
	end
*/