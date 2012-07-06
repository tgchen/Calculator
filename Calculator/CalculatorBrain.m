//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Eric Chen on 12/6/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack =_operandStack;

-(NSMutableArray *)operandStack{
    if(_operandStack == nil) _operandStack=[[NSMutableArray alloc]init];
    return _operandStack;
}

-(void)pushOperand:(double)operand
{
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

-(double) popOperand{
    NSNumber  *operandObject= [self.operandStack lastObject];
    if(operandObject)[self.operandStack removeLastObject];
    
    return [operandObject doubleValue];
}
-(double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if([operation isEqualToString:@"+"]){
        result =[self popOperand] + [self popOperand];
    }else if([@"*" isEqualToString:operation]){
        result =[self popOperand] * [self popOperand];
    }else if([@"-" isEqualToString:operation]){
        double subResult = [self popOperand];
        result = [self popOperand] - subResult;
    }else if([operation isEqualToString:@"/"]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand]/divisor;
    }else if([@"=" isEqualToString:operation]){
        result =[self popOperand];
    }else if([@"C" isEqualToString:operation]){
        [self.operandStack removeAllObjects];
        result =0;
    }else if([@"sin" isEqualToString:operation]){
        result = sin([self popOperand]);
    }else if ([@"cos" isEqualToString:operation]){
        result = cos([self popOperand]);
    }else if ([@"sqrt" isEqualToString:operation]){
        result = sqrt([self popOperand]);
    }else if ([@"pi" isEqualToString:operation]){
        result = M_PI;
    }
    
    [self pushOperand:result];
    NSLog(@"%g", result);
    return result;
}



@end
