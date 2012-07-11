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

-(void)pushVariable:(NSString *)variable 
{
   [self.programStack addObject:variable];
}


-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}
 
-(id) program 
{
    return [self.programStack copy];  
}



+(double) runProgram:(id)program 
 usingVariableValues:(NSDictionary *)variableVaules {
    if(![program isKindOfClass:[NSArray class]]) return 0;
    
    NSMutableArray *stack=[program mutableCopy];
    
    for(int i=0;i<[stack count];i++){
        id obj=[stack objectAtIndex:i];
        if([obj isKindOfClass:[NSString class]] && ![self isOperation:obj]){
            id value = [ variableVaules objectForKey:obj];
            if (![value isKindOfClass:[NSNumber class]]) {
                value = [NSNumber numberWithInt:0];
            }
            
        [stack replaceObjectAtIndex:i withObject:value];
        }
    }
    
    return [self popOperandOffStack:stack];
}

+(double)runProgram:(id)program{
    return [self runProgram:program usingVariableValues:nil];
}
                
                
+(BOOL)isOperation:(NSString *)operation {
 
    NSSet *operationSet = [NSSet setWithObjects:@"+", @"*", @"-", @"/",
                           @"sin", @"cos", @"sqrt", @"pi",nil];
    return [operationSet containsObject:operation];
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

+(NSSet *)variableUsedInProgram:(id)program{
    if(![program isKindOfClass:[NSArray class]]) return nil;
    
    NSMutableArray *variables = [NSMutableSet set];
    
    for(id obj in program){
        if([obj isKindOfClass:[NSString class]] && ![self isOperation:obj]){
            [variables addObject:obj];
        }
    }
    if ([variables count] ==0) return nil; else return [variables copy];
}
      
-(void)clear {
    self.programStack = nil;
}




@end
