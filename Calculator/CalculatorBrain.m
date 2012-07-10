//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Eric Chen on 12/6/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain
@synthesize programStack =_programStack;

-(NSMutableArray *)programStack{
    if(_programStack== nil) _programStack=[[NSMutableArray alloc]init];
    return _programStack;
}

-(void)pushOperand:(double)operand
{
    
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}



-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runprogram:self.program];
}
    double result = 0;
-(id) program 
{
    return [self.programStack copy];  
}



+(double) runprogram:(id)program{
    
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
        
    }
    return [self popOperandOffStack:stack];
}

+(double)popOperandOffStack:(NSMutableArray *)stack 
{
    double result = 0;
    id topOfStack = [stack lastObject]; 
    if(topOfStack) [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        if([operation isEqualToString:@"+"]){
            result =[self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }else if([@"*" isEqualToString:operation]){
            result =[self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }else if([@"-" isEqualToString:operation]){
            double subResult = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subResult;
        }else if([operation isEqualToString:@"/"]){
            double divisor = [self popOperandOffStack:stack];
            if (divisor) result = [self popOperandOffStack:stack]/divisor;
        }else if([@"sin" isEqualToString:operation]){
            result = sin([self popOperandOffStack:stack]);
        }else if ([@"cos" isEqualToString:operation]){
            result = cos([self popOperandOffStack:stack]);
        }else if ([@"sqrt" isEqualToString:operation]){
            result = sqrt([self popOperandOffStack:stack]);
        }else if ([@"pi" isEqualToString:operation]){
            result = M_PI;
        }

    }    

    return result;
}

      
-(void)clear {
    self.programStack = nil;
}




@end
