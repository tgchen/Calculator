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
@property (nonatomic, strong) NSDictionary *testVariableValues;

@end

@implementation CalculatorViewController

@synthesize display=_display;
@synthesize calculation = _calculation;
@synthesize userIsInTheMiddleOfEnteringNumber=_userIsInTheMiddleOfEnteringNumber;
@synthesize testVariableValues=_testVariableValues;
@synthesize brain =_brain;

- (CalculatorBrain *) brain{
    if(!_brain) _brain=[[CalculatorBrain alloc] init];
    return _brain;
}

-(void)appearCalculation:(NSString *)text{
    //self.calculation.text =[self.calculation.text  stringByReplacingOccurrencesOfString:@" = " withString:@""];
    
    self.calculation.text = [self.calculation.text stringByAppendingFormat:[NSString stringWithFormat:@"%@ ", text]];
}

-(void)syncView{
    // Find the result by running the program passing in the test variable values
    id result = [CalculatorBrain runProgram:(self.brain.program) usingVariableValues:(self.testVariableValues)];
    
    // If the result is a string, then display it, otherwise get the Number's description
    if ([result isKindOfClass:[NSString class]]) self.display.text = result;
    else self.display.text = [NSString stringWithFormat:@"%g", [result doubleValue]];
    
    // Now the calculation label, from the latest description of program 
    self.calculation.text = 
    [CalculatorBrain descriptionOfProgram:self.brain.program];
}

- (IBAction)dotPressed {
    if(!self.userIsInTheMiddleOfEnteringNumber){
        self.display.text = @"0.";
    } else {
        NSRange range =[self.display.text rangeOfString:@"."];
        if(range.location == NSNotFound){
        self.display.text = [self.display.text stringByAppendingString:@"."];
        }
    }
    self.userIsInTheMiddleOfEnteringNumber=YES;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if(self.userIsInTheMiddleOfEnteringNumber){
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringNumber = YES;
        
    }
    
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self appearCalculation:self.display.text];
    self.userIsInTheMiddleOfEnteringNumber = NO;
    
}
- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringNumber){
        [self enterPressed];
    }
    NSString *operation =[sender currentTitle];
    //self appearCalculation:[operation stringByAppendingFormat:@" = "]];
    [self appearCalculation:operation];
    id result = [self.brain performOperation:operation];
    
    self.display.text=[NSString stringWithFormat:@"%g", [result doubleValue]];
  
}

- (IBAction)clearPressed {
    [self.brain clear];
    self.display.text = @"0";
    self.calculation.text =@"";
    self.userIsInTheMiddleOfEnteringNumber =NO;

}

- (IBAction)backspacePressed {
    self.display.text=[self.display.text substringToIndex:[self.display.text length] -1];
    if( [self.display.text isEqualToString:@""]
       ||[self.display.text isEqualToString:@"-"]){
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringNumber =NO;
    }

}

- (IBAction)variablePressed:(UIButton *)sender {
    [self.brain pushVariable:sender.currentTitle];
    [self syncView];
}

- (IBAction)testPressed {
    self.testVariableValues = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithDouble:-4], @"x",
                               [NSNumber numberWithDouble:3], @"a",
                               [NSNumber numberWithDouble:4], @"b", nil];
    [self syncView];
}

@end
