//
//  ViewController.m
//  TruLanguage
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "ViewController.h"
#import "TruExpr.h"
#import "TruAnd.h"
#import "TruOr.h"
#import "TruNand.h"
#import <Foundation/Foundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (BOOL)truInterpret:(TruExpr*)expression withDefinitions:(NSArray*)defs {
    if ([expression isKindOfClass:[TruValue class]]) {
        return YES;
    } else if ([expression isKindOfClass:[TruNot class]]){
        return ![self truInterpret:[(TruNot*) expression expression]
                    withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruAnd class]]) {
    return
        [self truInterpret:[(TruAnd*) expression lhs]
           withDefinitions:defs] &&
        [self truInterpret:[(TruAnd*) expression rhs]
           withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruOr class]]) {
    return
        [self truInterpret:[(TruOr*) expression lhs]
           withDefinitions:defs] &&
        [self truInterpret:[(TruOr*) expression rhs]
           withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruNand class]]) {
    return
        ![self truInterpret:[[TruAnd alloc]
                             initWithLhs:[(TruNand*) expression lhs]
                             andRhs:[(TruNand*) expression rhs]]
            withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruNor class]]) {
    return
        ![self truInterpret:[[TruOr alloc]
                             initWithLhs:[(TruNor*) expression lhs]
                             andRhs:[(TruNor*) expression rhs]]
            withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruXor class]]) {
    return
        [self truInterpret:[[TruOr alloc]
                             initWithLhs:[(TruXor*) expression lhs]
                             andRhs:[(TruXor*) expression rhs]]
           withDefinitions:defs] &&
        [self truInterpret:[[TruNand alloc]
                          initWithLhs:[(TruXor*) expression lhs]
                          andRhs:[(TruXor*) expression rhs]]
        withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruXnor class]]) {
    return
        [self truInterpret:[[TruNand alloc]
                             initWithLhs:[[TruOr alloc]
                                          initWithLhs:[(TruXnor*) expression lhs]
                                          andRhs:[(TruXnor*) expression rhs]]
                             andRhs:[[TruNand alloc]
                                     initWithLhs:[(TruXnor*) expression lhs]
                                     andRhs:[(TruXnor*) expression rhs]]]
           withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruImply class]]) {
    return
        [self truInterpret:[[TruOr alloc]
                             initWithLhs:[[TruOr alloc]
                                          initWithLhs:[(TruXnor*) expression lhs]
                                          andRhs:[(TruXnor*) expression rhs]]
                             andRhs:[[TruNand alloc]
                                     initWithLhs:[(TruXnor*) expression lhs]
                                     andRhs:[(TruXnor*) expression rhs]]]
           withDefinitions:defs];
        //    [(tru-imply lhs rhs) (tru-interpret (tru-or (tru-not  lhs) rhs) defs)]
    } else {
        return NO;
    }
}

// TODO make other functions "functions" not "methods" like this
//int factorial(int value)
//{
//  if (value == 1) {
//    return value;
//  } else {
//    return value * factorial(value - 1);
//  }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
