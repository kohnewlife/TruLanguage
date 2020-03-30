//
//  ViewController.m
//  TruLanguage
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "TruExpr.h"
#import "TruId.h"
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
#import "TruFunction.h"

// MARK: - View Controller
@interface ViewController ()
@end

@implementation ViewController

- (TruDefinition*) truLookup:(NSString*) func with:(NSArray*) definitions
{
    for (TruDefinition* def in definitions) {
        if (func == [(TruFunction*) def name]) {
            return def;
        }
    }
    return nil;
}

- (TruExpr*) truSubstitute:(TruExpr*) expr in:(NSString*) symbol for:(TruExpr*) newExpr
{
    if ([newExpr isKindOfClass:[TruValue class]]) {
        return newExpr;
    } else if ([newExpr isKindOfClass:[TruNot class]]){
        return [[TruNot alloc]
                init:[self truSubstitute:expr in:symbol for:[(TruNot*) newExpr expression]]];
    } else if ([newExpr isKindOfClass:[TruAnd class]]) {
        return [[TruAnd alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruAnd*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruAnd*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruOr class]]) {
        return [[TruOr alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruOr*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruOr*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruNand class]]) {
        return [[TruNand alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruNand*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruNand*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruNor class]]) {
        return [[TruNor alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruNor*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruNor*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruXor class]]) {
        return [[TruXor alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruXor*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruXor*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruXnor class]]) {
        return [[TruXnor alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruXnor*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruXnor*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruImply class]]) {
        return [[TruImply alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruImply*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruImply*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruEqual class]]) {
        return [[TruEqual alloc]
                initWithLhs:[self truSubstitute:expr in:symbol for:[(TruEqual*) newExpr lhs]]
                andRhs:     [self truSubstitute:expr in:symbol for:[(TruEqual*) newExpr rhs]]];
    } else if ([newExpr isKindOfClass:[TruMaj class]]) {
        return [[TruMaj alloc]
                initWithFirst:[self truSubstitute:expr in:symbol for:[(TruMaj*) newExpr first]]
                second:     [self truSubstitute:expr in:symbol for:[(TruMaj*) newExpr second]]
                andThird:   [self truSubstitute:expr in:symbol for:[(TruMaj*) newExpr third]]];
    } else if ([newExpr isKindOfClass:[TruId class]]) {
        return symbol == [(TruId*) newExpr name] ? expr : newExpr;
    } else if ([newExpr isKindOfClass:[TruCall class]]) {
        NSArray *oldArguments = [(TruCall*) newExpr arguments];
        NSMutableArray *newArguments = [NSMutableArray array];
        for (TruExpr *arg in oldArguments) {
            [newArguments addObject:[self truSubstitute:expr in:symbol for:arg]];
        }
        return [[TruCall alloc]
                initWithFunction:[(TruCall*) newExpr function]
                andExpressions:[newArguments copy]];
    } else {
        return nil;
    }
}

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
        TruDefinition *def  = [self truLookup:[(TruCall*) expression function] with:defs];
        TruExpr* body = [(TruFunction*)def body];
        NSArray *arguments  = [(TruCall*)expression arguments];
        NSArray *parameters = [(TruFunction*)def parameters];
        if ([arguments count] != [parameters count]) {
            printf("wrong number of arguments");
            return nil;
        }
        for (int i = 0; [arguments count]; i++) {
            TruExpr *arg = [arguments objectAtIndex:i];
            NSString *param = [parameters objectAtIndex:i];
            TruExpr *argExpr = [[TruValue alloc]
                                init:[self truInterpret:arg withDefinitions:defs]];
            body = [self truSubstitute:argExpr in:param for:body];
        }
        return [self truInterpret:body withDefinitions:defs];
    } else {
        return NO;
    }
}

// concrete syntax for Truing language
// true | false
// {not  true}
// {and  true  false}
// {or   false false}
// {nand true  false}
// {nor  false false}
// {xor  true  true}
// {xnor false true}
// {implies    true  false}
// {equals     false false}
// {majority   true  true false}
// {and  {or   true  false} false}
// {not  {and  true  {or false true}}}
// {nand {nor  false true}  true}
// {xor  {xnor true  false} true}
// {implies  {equals false  true} false}
// {majority {not  {and false true}} {nor true true} {implies false false}}
// x
// {my-not false}
// (E)BNF (Extended) Backus-Naur Form
// <expression> ::= <value> | <not> | <and> | <or> | <nand> |
//                  <nor> | <xor> | <xnor> | <implies> |
//                  <equals> | <majority> | <id> | <call>
// <value>      ::= true | false
// <and>        ::= "{" "and"  <expression> <expression> "}"
// <or>         ::= "{" "or"   <expression> <expression> "}"
// <not>        ::= "{" "not"  <expression> "}"
// <nand>       ::= "{" "nand" <expression> <expression> "}"
// <nor>        ::= "{" "nor"  <expression> <expression> "}"
// <xor>        ::= "{" "xor"  <expression> <expression> "}"
// <xnor>       ::= "{" "xnor" <expression> <expression> "}"
// <implies>    ::= "{" "implies"  <expression> <expression> "}"
// <equals>     ::= "{" "equals"   <expression> <expression> "}"
// <majority>   ::= "{" "majority" <expression> <expression> <expression> "}"
// <id> ::= <character>+
// <call> ::= "{" <id> <expression> "}"
// <definition> ::= "{" "define" "{" <id> <id> "}" <expression> "}"


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end

