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
    }else if([@"-" isEqualToString:operation]){
        double subResult = [self popOperand];
        result = [self popOperand ] - subResult;
    }else if([@"=" isEqualToString:operation]){
        result =[self popOperand];
    }else if([@"C" isEqualToString:operation]){
        [self.operandStack removeAllObjects];
        result =0;
        
    }
    
    [self pushOperand:result];
    NSLog(@"%g", result);
    return result;
}



@end
