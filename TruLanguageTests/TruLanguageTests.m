//
//  TruLanguageTests.m
//  TruLanguageTests
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "TruValue.h"

@interface TruLanguageTests : XCTestCase
@property ViewController *sut;
@end

@implementation TruLanguageTests

- (void)setUp {
    _sut = [[ViewController alloc] init];
}

- (void)tearDown {
    _sut = nil;
}

- (void)testTruLookup {
    // GIVEN
    // `{my-false} false
    TruDefinition *falsey = [[TruFunction alloc] initWithName:@"my-false" parameters:nil andBody:false];
    // `{my-not value} {nand true value}
    TruDefinition *notty =
        [[TruFunction alloc]
         initWithName:@"my-not"
         parameters:@[@"value"]
         andBody:[[TruNand alloc]
                  initWithLhs:[[TruValue alloc] init:true]
                  andRhs:[[TruId alloc] init:@"value"]]];
    // `{my-xor x y} {and {or x y} {not {and x y}}}
    TruDefinition *xorry =
        [[TruFunction alloc]
         initWithName:@"my-xor"
         parameters:@[@"x", @"y"]
         andBody:[[TruAnd alloc]
                  initWithLhs:[[TruOr alloc]
                               initWithLhs:[[TruId alloc] init:@"x"]
                               andRhs:[[TruId alloc] init:@"y"]]
                  andRhs:[[TruNot alloc]
                          init:[[TruAnd alloc]
                                initWithLhs:[[TruId alloc] init:@"x"]
                                andRhs:[[TruId alloc] init:@"y"]]]]];
    // `{my-majority a b c} {or {or {and a b} {and a c}} {and b c}}
    TruDefinition *majy =
        [[TruFunction alloc]
         initWithName:@"my-majority"
         parameters:@[@"a", @"b", @"c"]
         andBody:[[TruOr alloc]
                  initWithLhs:[[TruOr alloc]
                               initWithLhs:[[TruAnd alloc]
                                            initWithLhs:[[TruId alloc]
                                                         init:@"a"]
                                            andRhs:[[TruId alloc]
                                                    init:@"b"]]
                               andRhs:[[TruAnd alloc]
                                       initWithLhs:[[TruId alloc]
                                                    init:@"a"]
                                       andRhs:[[TruId alloc]
                                               init:@"c"]]]
                  andRhs:[[TruAnd alloc]
                          initWithLhs:[[TruId alloc] init:@"b"]
                          andRhs:[[TruId alloc] init:@"c"]]]];
    
    
    // GIVEN
    NSArray *group1 = @[xorry, notty, majy, falsey];
    NSArray *group2 = @[notty, falsey];
    NSArray *group3 = @[xorry, notty];
    
    // THEN
    XCTAssertEqual([_sut truLookup:@"my-false" with:@[falsey]], falsey);
    XCTAssertEqual([_sut truLookup:@"my-false" with:group1], falsey);
    XCTAssertEqual([_sut truLookup:@"my-not" with:@[notty]], notty);
    XCTAssertEqual([_sut truLookup:@"my-not" with:group2], notty);
    XCTAssertEqual([_sut truLookup:@"my-not" with:group3], notty);
    XCTAssertEqual([_sut truLookup:@"my-xor" with:group3], xorry);
    XCTAssertEqual([_sut truLookup:@"my-majority" with:@[majy]], majy);
    XCTAssertEqual([_sut truLookup:@"my-majority" with:group1], majy);
    XCTAssertNil([_sut truLookup:@"my-not" with:nil]);
}

- (void)testTruSubstitute {
    // GIVEN
    TruValue *falseVal = [[TruValue alloc] init:false];
    TruValue *trueVal = [[TruValue alloc] init:true];
    TruId *x = [[TruId alloc] init:@"x"];
    TruId *y = [[TruId alloc] init:@"y"];
    TruNot *notX = [[TruNot alloc] init:[[TruId alloc] init:@"x"]];
    TruAnd *andXY = [[TruAnd alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruOr *orXY = [[TruOr alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruNand *nandXY = [[TruNand alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruNor *norXY = [[TruNor alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruXor *xorXY = [[TruXor alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruXnor *xnorXY = [[TruXnor alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruImply *implyXY = [[TruImply alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruEqual *equalXY = [[TruEqual alloc] initWithLhs:[[TruId alloc] init:@"x"] andRhs:[[TruId alloc] init:@"y"]];
    TruMaj *majXYZ = [[TruMaj alloc] initWithFirst:[[TruId alloc] init:@"x"] second:[[TruId alloc] init:@"y"] andThird:[[TruId alloc] init:@"z"]];
    
    // WHEN
    TruExpr *notFalse = [_sut truSubstitute:falseVal in:@"x" for:notX];
    TruExpr *andTrueY = [_sut truSubstitute:trueVal in:@"x" for:andXY];
    TruExpr *orXFalse = [_sut truSubstitute:falseVal in:@"y" for:orXY];
    TruExpr *nandTrueY = [_sut truSubstitute:trueVal in:@"x" for:nandXY];
    TruExpr *norXTrue = [_sut truSubstitute:trueVal in:@"y" for:norXY];
    TruExpr *xorFalseY = [_sut truSubstitute:falseVal in:@"x" for:xorXY];
    TruExpr *xnorXFalse = [_sut truSubstitute:falseVal in:@"y" for:xnorXY];
    
    // THEN
    XCTAssertEqual([_sut truSubstitute:trueVal in:@"x" for:falseVal], falseVal);
    XCTAssertEqual([_sut truSubstitute:trueVal in:@"x" for:x], trueVal);
    XCTAssertEqual([_sut truSubstitute:trueVal in:@"x" for:y], y);
    XCTAssertEqual([(TruValue*) [(TruNot*) notFalse expression] value], false);
    XCTAssertEqual([(TruId*) [(TruAnd*) andTrueY rhs] name], @"y");
    XCTAssertEqual([(TruId*) [(TruOr*) orXFalse lhs] name], @"x");
    XCTAssertEqual([(TruId*) [(TruNand*) nandTrueY rhs] name], @"y");
    XCTAssertEqual([(TruId*) [(TruNor*) norXTrue lhs] name], @"x");
    XCTAssertEqual([(TruId*) [(TruXor*) xorFalseY rhs] name], @"y");
    XCTAssertEqual([(TruId*) [(TruXnor*) xnorXFalse lhs] name], @"x");
    
    //  (test (tru-substitute (tru-parse-expression `false) 'x (tru-parse-expression `{implies x y}))
    //        (tru-parse-expression `{implies false y}))
    //  (test (tru-substitute (tru-parse-expression `true)  'y (tru-parse-expression `{equals x y}))
    //        (tru-eq (tru-id 'x) (tru-value #t)))
    //  (test (tru-substitute (tru-parse-expression `false) 'z (tru-parse-expression `{majority x y z}))
    //        (tru-parse-expression `{majority x y false}))

    //  (test (tru-substitute (tru-parse-expression `true)  'x (tru-parse-expression `{my-false}))
    //        (tru-parse-expression `{my-false}))
    //  (test (tru-substitute (tru-parse-expression `false) 'x (tru-parse-expression `{my-not x}))
    //        (tru-call1 'my-not (tru-value #f)))
    //  (test (tru-substitute (tru-parse-expression `true)  'y (tru-parse-expression `{my-xor x y}))
    //        (tru-parse-expression `{my-xor x true}))
    //  (test (tru-substitute (tru-parse-expression `false) 'z (tru-parse-expression `{my-majority x y z}))
    //        (tru-call3 'my-majority (tru-id 'x) (tru-id 'y) (tru-value #f)))
}

@end
