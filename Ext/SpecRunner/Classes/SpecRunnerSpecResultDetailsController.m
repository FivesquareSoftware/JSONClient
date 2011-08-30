//
//  SpecRunnerSpecResultDetailsController.m
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

#import "SpecRunnerSpecResultDetailsController.h"

#import "SpecRunnerLabelValueCell.h"
#import "SpecRunnerSpecResultErrorDetailsController.h"

#import "OCExampleResult.h"


static NSString *kResultDetailsCellIdentifier = @"kResultDetailsCellIdentifier";

enum  {
    GROUP_SECTION
    , EXAMPLE_NAME_SECTION
    , EXAMPLE_TIME_SECTION
    , EXAMPLE_STATUS_SECTION
    , EXAMPLE_ERROR_SECTION
};

@implementation SpecRunnerSpecResultDetailsController

// Properties  ============================================================== //

#pragma mark -
#pragma mark Properties

@synthesize result;

- (void) setResult:(OCExampleResult *)newResult {
    if(result != newResult){
        result = newResult;
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
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecRunnerLabelValueCell *cell = (SpecRunnerLabelValueCell *)[tableView dequeueReusableCellWithIdentifier:kResultDetailsCellIdentifier];
    if(cell == nil) {
        cell = [[[SpecRunnerLabelValueCell alloc] initWithFrame:CGRectZero reuseIdentifier:kResultDetailsCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case GROUP_SECTION:
            [cell setLabel:@"Group"];
            [cell setValue:[self.result.group description]];
            break;
        case EXAMPLE_NAME_SECTION:
            [cell setLabel:@"Example"];
            [cell setValue:self.result.exampleName];
            break;
        case EXAMPLE_TIME_SECTION:
            [cell setLabel:@"Elapsed"];
            [cell setValue:[NSString stringWithFormat:@"%d (ms)",self.result.elapsed]];
            break;
        case EXAMPLE_STATUS_SECTION:
            [cell setLabel:@"Status"];
            [cell setValue:self.result.success ? @"Success" : @"Fail"];
            break;
        case EXAMPLE_ERROR_SECTION:
            [cell setLabel:@"Error"];
            if(self.result.error) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                [cell setValue:[self.result.error name]];
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setValue:@""];
            }
            break;
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == EXAMPLE_ERROR_SECTION) {
        return indexPath;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.result.error) {
        errorDetailsController.error = self.result.error;
        [self.navigationController pushViewController:errorDetailsController animated:YES];
    }
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


// Helpers  ================================================================= //

#pragma mark -
#pragma mark Helpers


@end

