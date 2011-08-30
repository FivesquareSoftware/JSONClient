//
//  SpecRunnerAppDelegate.h
//  SpecRunner
//
//  Created by John Clayton on 12/23/2008.
//  Copyright Fivesquare Software, LLC 2008. All rights reserved.
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


#import <UIKit/UIKit.h>

@class SpecRunnerSpecResultsController;
@class OCSpecRunner;

@interface SpecRunnerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IBOutlet UINavigationController *navigationController;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    SpecRunnerSpecResultsController *specResultsController;
    OCSpecRunner *srunner;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SpecRunnerSpecResultsController *specResultsController;
@property (nonatomic, retain) OCSpecRunner *srunner;


- (void) runSpecs:(id)sender;
- (void) runningSpecs;
- (void) stoppedSpecs;

@end


