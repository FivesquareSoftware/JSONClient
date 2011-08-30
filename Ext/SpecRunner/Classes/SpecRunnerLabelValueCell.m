//
//  SpecRunnerExampleResultDetailsCell.m
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


#import "SpecRunnerLabelValueCell.h"


#define HEIGHT 45.0
#define PADDING 10.0
#define LABEL_WIDTH 58.0


@implementation SpecRunnerLabelValueCell

// Properties  ============================================================== //

#pragma mark -
#pragma mark Properties

@synthesize keyLabel, valueLabel;

- (void) setLabel:(NSString *)aLabel {
    self.keyLabel.text = aLabel;
}

- (void) setValue:(NSString *)aValue {
    self.valueLabel.text = aValue;
}


// Cell  ==================================================================== //

#pragma mark -
#pragma mark Properties


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, LABEL_WIDTH, HEIGHT)];
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.font = [UIFont boldSystemFontOfSize:12.0];
        aLabel.textAlignment = UITextAlignmentRight;
        aLabel.textColor = [UIColor colorWithRed:(107.0/255.0) green:(127.0/255.0) blue:(155.0/255.0) alpha:1.0]; 
        aLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin; 
        [self.contentView addSubview:aLabel];
        self.keyLabel = aLabel;
        [aLabel release];
        
        aLabel = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_WIDTH + PADDING, 0.0, (320.0 - (LABEL_WIDTH + (PADDING * 3.0))), HEIGHT)];
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.font = [UIFont boldSystemFontOfSize:12.0];
        aLabel.textColor = [UIColor blackColor];
        aLabel.lineBreakMode = UILineBreakModeWordWrap;
        aLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:aLabel];
        self.valueLabel = aLabel;
        [aLabel release];
        
        
    }
    return self;
}

- (void)dealloc {
    [keyLabel release];
    [valueLabel release];
    [super dealloc];
}


@end
