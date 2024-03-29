//
//  SpecRunnerSpecResultsController.m
//  SpecRunner
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


#import "SpecRunnerSpecResultsController.h"

#import "SpecRunnerExampleResultCell.h"
#import "SpecRunnerSpecResultDetailsController.h"

#import  "SpecRunnerGroupResults.h"
#import "OCSpec.h"


static NSString *kExampleResultCellIdentifier = @"kExampleResultCellIdentifier";

@implementation SpecRunnerSpecResultsController


// Properties  ============================================================== //

#pragma mark -
#pragma mark Properties


@synthesize tableData;



// Object  ================================================================== //

#pragma mark -
#pragma mark Object

- (void)dealloc {
    [tableData release];
    [super dealloc];
}


// Table View Data Source  ================================================== //

#pragma mark -
#pragma mark Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self hasResults] ? [self.tableData count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self hasResults]) {
        SpecRunnerGroupResults *resultsAtIndex = (SpecRunnerGroupResults *)[self.tableData objectAtIndex:section];
        return [resultsAtIndex numberOfResults];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecRunnerGroupResults *groupAtIndex = (SpecRunnerGroupResults *)[self.tableData objectAtIndex:indexPath.section];
    OCExampleResult *resultAtIndex = [groupAtIndex resultAtIndex:indexPath.row];
    SpecRunnerExampleResultCell *cell = (SpecRunnerExampleResultCell *)[tableView dequeueReusableCellWithIdentifier:kExampleResultCellIdentifier];
    if(cell == nil) {
        cell = [[[SpecRunnerExampleResultCell alloc] initWithFrame:CGRectZero reuseIdentifier:kExampleResultCellIdentifier] autorelease];
        cell.font = [UIFont boldSystemFontOfSize:14.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.target = self;
    }
    cell.result = resultAtIndex;
    cell.showsReorderControl = NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecRunnerGroupResults *groupAtIndex = (SpecRunnerGroupResults *)[self.tableData objectAtIndex:indexPath.section];
    OCExampleResult *resultAtIndex = [groupAtIndex resultAtIndex:indexPath.row];
	detailViewController.result = resultAtIndex;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if([self hasResults]) {
        UIView *hview = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 22.0)] autorelease];
        hview.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        hview.backgroundColor = [UIColor blackColor];
        hview.alpha = 0.5;
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0, 0, 308.0, 22.0)];
        aLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        aLabel.opaque = NO;
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.font = [UIFont boldSystemFontOfSize:14.0];
        aLabel.textAlignment = UITextAlignmentLeft;
        aLabel.textColor = [UIColor whiteColor]; 
        aLabel.text = [(SpecRunnerGroupResults *)[self.tableData objectAtIndex:section] description];
        [hview addSubview:aLabel];
        [aLabel release];
        return hview;
    }
    return nil;
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


// Spec Runner Delegate  ==================================================== //

#pragma mark -
#pragma mark Spec Runner Delegate


- (void) exampleDidFinish:(OCExampleResult *)result {
    [self addResult:result];
    [self.tableView reloadData];
}

- (void) errorRunningGroup:(NSDictionary *)errorInfo {
    Class group = [errorInfo objectForKey:kOCErrorInfoKeyGroup];
    NSString *msg = [errorInfo objectForKey:kOCErrorInfoKeyMessage];
    
    NSString *alertMsg = [NSString stringWithFormat:@"Could not run group '%@'",group];
    
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Spec Error" 
                          message:alertMsg 
                          delegate:self 
                          cancelButtonTitle:@"OK" 
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
     

// Helpers  ================================================================= //

#pragma mark -
#pragma mark Helpers

- (void) resetResultsData {
    self.tableData = [[[NSMutableArray alloc] init] autorelease];
}

- (BOOL) hasResults {
    return [self.tableData count] > 0;
}

- (SpecRunnerGroupResults *) resultsForGroup:(Class)aGroup {
    SpecRunnerGroupResults *foundGroup = [SpecRunnerGroupResults withGroup:aGroup];
    NSUInteger idx = [self.tableData indexOfObject:foundGroup];
    if(idx == NSNotFound) {
        [self.tableData insertObject:foundGroup atIndex:[self.tableData count]];
    } else {
        foundGroup = [self.tableData objectAtIndex:idx];
    }
    return foundGroup;
}

- (void) addResult:(OCExampleResult *)result {    
    [[self resultsForGroup:result.group] addResult:result];
}

@end

