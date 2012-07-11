//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Eric Chen on 12/6/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)clear;

@property (readonly) id program;

+ (double) runProgram:(id)program
  usingVariableValues:(NSDictionary *)variableValues;
//+ (NSString *) descriptionOfProgram:(id)program;

@end
