//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Eric Chen on 12/6/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain; 
@end

@implementation CalculatorViewController

@synthesize display=_display;
@synthesize userIsInTheMiddleOfEnteringNumber=_userIsInTheMiddleOfEnteringNumber;
@synthesize brain =_brain;

- (CalculatorBrain *) brain{
    if(!_brain) _brain=[[CalculatorBrain alloc] init];
    return _brain;
}
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if(self.userIsInTheMiddleOfEnteringNumber){
        self.display.text=[self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
    
}

- (IBAction)equalPressed:(UIButton *)sender {
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text=resultString;
}


- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringNumber = NO;
    
}
- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringNumber){
        [self enterPressed];
    } 
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text=resultString;
}


@end
