//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Eric Chen on 12/6/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject


@property (readonly) id program;
-(void)pushOperand:(double)operand;
-(void)pushVariable:(NSString *)variable;
-(void)pushOperation:(NSString *)operation;
-(double)performOperation:(NSString *)operation;
-(void) clear;

+(NSString *) descriptionOfProgram:(id)stack;
+(double) runProgram:(id)progrm
          usingVariableValues:(NSDictionary *)variableValues;

@end
