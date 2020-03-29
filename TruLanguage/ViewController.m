//
//  ViewController.m
//  TruLanguage
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "ViewController.h"
#import "TruExpr.h"
#import "TruValue.h"
#import "TruNot.h"
#import "TruAnd.h"
#import "TruOr.h"
#import "TruNand.h"
#import "TruNor.h"
#import "TruXor.h"
#import "TruXnor.h"
#import "TruImply.h"
#import "TruEqual.h"
#import "TruMaj.h"
#import "TruCall.h"
#import "TruDefinition.h"
#import <Foundation/Foundation.h>

// MARK: - Helpers
TruDefinition* truLookup(NSString* func, NSArray* definitions)
{
    for (TruDefinition* def in definitions) {
        if (func == [(TruFunction*) def name]) {
            return def;
        }
    }
    return nil;
}

TruExpr* truSubstitute(TruExpr* expr, NSString* symbol, TruExpr* newExpr)
{
    if ([newExpr isKindOfClass:[TruValue class]]) {
        return newExpr;
    } else if ([newExpr isKindOfClass:[TruNot class]]){
        return [[TruNot alloc]
                init:truSubstitute(expr, symbol, [(TruNot*) newExpr expression])];
    } else if ([newExpr isKindOfClass:[TruAnd class]]) {
        return [[TruAnd alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruAnd*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruAnd*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruOr class]]) {
        return [[TruOr alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruOr*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruOr*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruNand class]]) {
        return [[TruNand alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruNand*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruNand*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruNor class]]) {
        return [[TruNor alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruNor*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruNor*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruXor class]]) {
        return [[TruXor alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruXor*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruXor*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruXnor class]]) {
        return [[TruXnor alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruXnor*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruXnor*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruImply class]]) {
        return [[TruImply alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruImply*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruImply*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruEqual class]]) {
        return [[TruEqual alloc]
                initWithLhs:truSubstitute(expr, symbol, [(TruEqual*) newExpr lhs])
                andRhs:truSubstitute(expr, symbol, [(TruEqual*) newExpr rhs])];;
    } else if ([newExpr isKindOfClass:[TruMaj class]]) {
        return [[TruMaj alloc]
                initWithFirst:truSubstitute(expr, symbol, [(TruMaj*) newExpr first])
                second:truSubstitute(expr, symbol, [(TruMaj*) newExpr second])
                andThird:truSubstitute(expr, symbol, [(TruMaj*) newExpr third])];
    } else if ([newExpr isKindOfClass:[TruId class]]) {
        return symbol == [(TruId*) newExpr name] ? expr : newExpr;
    } else if ([newExpr isKindOfClass:[TruCall class]]) {
        NSArray *oldArguments = [(TruCall*) newExpr arguments];
        NSMutableArray *newArguments = [NSMutableArray array];
        for (TruExpr *arg in oldArguments) {
            [newArguments addObject:truSubstitute(expr, symbol, arg)];
        }
        return [[TruCall alloc]
                initWithFunction:[(TruCall*) newExpr function]
                andExpressions:[newArguments copy]];
    } else {
        return nil;
    }
}

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
                             initWithLhs:[[TruNot alloc]
                                          init: [(TruXnor*) expression lhs]]
                             andRhs:[(TruXnor*) expression rhs]]
           withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruEqual class]]) {
    return
        [self truInterpret:[(TruEqual*) expression lhs]
            withDefinitions:defs] ==
        [self truInterpret:[(TruEqual*) expression rhs]
            withDefinitions:defs];
        
    } else if ([expression isKindOfClass:[TruMaj class]]) {
    return
        [self truInterpret:
         [[TruOr alloc]
          initWithLhs:[[TruOr alloc]
                       initWithLhs:[[TruAnd alloc]
                                    initWithLhs:[(TruMaj*) expression first]
                                    andRhs:[(TruMaj*) expression second]]
                       andRhs:[[TruAnd alloc]
                               initWithLhs:[(TruMaj*) expression first]
                               andRhs:[(TruMaj*) expression third]]]
          andRhs:[[TruAnd alloc]
                  initWithLhs:[(TruMaj*) expression second]
                  andRhs:[(TruMaj*) expression third]]]
         withDefinitions:defs];
    } else if ([expression isKindOfClass:[TruId class]]) {
        printf("unbound name");
        return nil;
        // TODO throw an error
        //    [(tru-id id) (error 'tru-interpret "unbound name")]
    } else if ([expression isKindOfClass:[TruCall class]]) {
        TruDefinition *def  = truLookup([(TruCall*) expression function], defs);
        TruExpr* body = [(TruFunction*)def body];
        NSArray *arguments  = [(TruCall*)expression arguments];
        NSArray *parameters = [(TruFunction*)def parameters];
        if ([arguments count] != [parameters count]) {
            printf("wrong number of arguments");
            return nil;
        }
        for (int i; [arguments count]; i++) {
            TruExpr *arg = [arguments objectAtIndex:i];
            NSString *param = [parameters objectAtIndex:i];
            TruExpr *argExpr = [[TruValue alloc]
                                init:[self truInterpret:arg withDefinitions:defs]];
            body = truSubstitute(argExpr, param, body);
        }
        return [self truInterpret:body withDefinitions:defs];
    } else {
        return NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

