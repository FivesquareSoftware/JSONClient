//
//  SpecRunnerSpecResultErrorDetailsController.m
//  SpecRunner
//
//  Created by John Clayton on 12/24/2008.
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

#import "SpecRunnerSpecResultErrorDetailsController.h"

#import "SpecRunnerLabelValueCell.h"

static NSString *kResultErrorDetailsCellIdentifier = @"kResultErrorDetailsCellIdentifier";

enum  {
    ERROR_NAME_SECTION
    , ERROR_REASON_SECTION
    , ERROR_INFO_SECTION
    , ERROR_TRACE_SECTION
};

#define HEIGHT 45.0
#define TEXT_VPADDING 10.0

@implementation SpecRunnerSpecResultErrorDetailsController

// Properties  ============================================================== //

#pragma mark -
#pragma mark Properties


@synthesize error;

- (void) setError:(NSException *)newError {
    if(error != newError) {
        error = newError;
        [self.tableView reloadData];
    }
}


// Object  ================================================================== //

#pragma mark -
#pragma mark Object

- (void)dealloc {
    [super dealloc];
}


// Table View Data Source  ================================================== //

#pragma mark -
#pragma mark Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecRunnerLabelValueCell *cell;
    cell = (SpecRunnerLabelValueCell *)[tableView dequeueReusableCellWithIdentifier:kResultErrorDetailsCellIdentifier];
    if(cell == nil) {
        cell = [[[SpecRunnerLabelValueCell alloc] initWithFrame:CGRectZero reuseIdentifier:kResultErrorDetailsCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.valueLabel.numberOfLines = 0; // unlimited
    }
    switch (indexPath.row) {
        case ERROR_NAME_SECTION:
            [cell setLabel:@"Name"];
            [cell setValue:[self.error name]];
            return cell;
        case ERROR_REASON_SECTION:
            [cell setLabel:@"Reason"];
            [cell setValue:[self.error reason]];
            return cell;
        case ERROR_INFO_SECTION:
            [cell setLabel:@"Info"];
            if([self.error userInfo]) {
                [cell setValue:[[self.error userInfo] description]];
            } else {
                [cell setValue:@""];
            }
            return cell;
        case ERROR_TRACE_SECTION:
            [cell setLabel:@"Trace"];
            if([self.error callStackReturnAddresses]) {
                [cell setValue:[[self.error callStackReturnAddresses] description]];
            } else {
                [cell setValue:@""];
            }
            return cell;
        default:
            break;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



// Table View Delegate  ===================================================== //

#pragma mark -
#pragma mark Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecRunnerLabelValueCell *cell = (SpecRunnerLabelValueCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = cell.valueLabel;
    [label sizeToFit];
    CGFloat textHeight = label.frame.size.height;
    if(textHeight > (45.0 - (TEXT_VPADDING * 2.0))) {
        return textHeight + (TEXT_VPADDING * 2.0);
    }
    return 45.0;
}

// View Controller  ========================================================= //

#pragma mark -
#pragma mark View Controller

- (void)viewDidLoad {    
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
    [super setEditing:editing animated:animate];
}





@end
