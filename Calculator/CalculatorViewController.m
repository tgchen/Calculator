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
@synthesize calculation = _calculation;


@synthesize userIsInTheMiddleOfEnteringNumber=_userIsInTheMiddleOfEnteringNumber;

@synthesize brain =_brain;

- (CalculatorBrain *) brain{
    if(!_brain) _brain=[[CalculatorBrain alloc] init];
    return _brain;
}

-(void)appearCalculation:(NSString *)text{
    //self.calculation.text =[self.calculation.text  stringByReplacingOccurrencesOfString:@"= " withString:@""];
    
    self.calculation.text = [self.calculation.text stringByAppendingFormat:[NSString stringWithFormat:@"%@ ", text]];
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
    //[self appearCalculation:[operation stringByAppendingFormat:@" ="]];
    [self appearCalculation:operation];
    double result = [self.brain performOperation:operation];
    
   self.display.text=[NSString stringWithFormat:@"%g", result];
  
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


@end
