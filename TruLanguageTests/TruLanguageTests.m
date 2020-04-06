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
    XCTAssertNil  ([_sut truLookup:@"my-not" with:nil]);
}

- (void)testTruSubstitute {
    // GIVEN
    TruValue *falseVal = [[TruValue alloc] init:false];
    TruValue *trueVal =  [[TruValue alloc] init:true];
    TruId *x = [[TruId alloc] init:@"x"];
    TruId *y = [[TruId alloc] init:@"y"];
    TruId *z = [[TruId alloc] init:@"z"];
    TruNot *notX =      [[TruNot   alloc] init:x];
    TruAnd *andXY =     [[TruAnd   alloc] initWithLhs:x andRhs:y];
    TruOr *orXY =       [[TruOr    alloc] initWithLhs:x andRhs:y];
    TruNand *nandXY =   [[TruNand  alloc] initWithLhs:x andRhs:y];
    TruNor *norXY =     [[TruNor   alloc] initWithLhs:x andRhs:y];
    TruXor *xorXY =     [[TruXor   alloc] initWithLhs:x andRhs:y];
    TruXnor *xnorXY =   [[TruXnor  alloc] initWithLhs:x andRhs:y];
    TruImply *implyXY = [[TruImply alloc] initWithLhs:x andRhs:y];
    TruEqual *equalXY = [[TruEqual alloc] initWithLhs:x andRhs:y];
    TruMaj *majXYZ =    [[TruMaj   alloc] initWithFirst:x second:y andThird:z];
    TruCall *myFalse =  [[TruCall  alloc] initWithFunction:@"my-false" andExpressions:nil];
    TruCall *myNot =    [[TruCall  alloc] initWithFunction:@"my-not" andExpressions:@[x]];
    TruCall *myXor =    [[TruCall  alloc] initWithFunction:@"my-xor" andExpressions:@[x, y]];
    TruCall *myMaj =    [[TruCall  alloc] initWithFunction:@"my-majority" andExpressions:@[x, y, z]];
    
    // WHEN
    TruExpr *notFalse =    [_sut truSubstitute:falseVal in:@"x" for:notX];
    TruExpr *andTrueY =    [_sut truSubstitute:trueVal  in:@"x" for:andXY];
    TruExpr *orXFalse =    [_sut truSubstitute:falseVal in:@"y" for:orXY];
    TruExpr *nandTrueY =   [_sut truSubstitute:trueVal  in:@"x" for:nandXY];
    TruExpr *norXTrue =    [_sut truSubstitute:trueVal  in:@"y" for:norXY];
    TruExpr *xorFalseY =   [_sut truSubstitute:falseVal in:@"x" for:xorXY];
    TruExpr *xnorXFalse =  [_sut truSubstitute:falseVal in:@"y" for:xnorXY];
    TruExpr *implyFalseY = [_sut truSubstitute:falseVal in:@"x" for:implyXY];
    TruExpr *equalXTrue =  [_sut truSubstitute:trueVal  in:@"y" for:equalXY];
    TruExpr *majXYFalse =  [_sut truSubstitute:falseVal in:@"z" for:majXYZ];
    TruExpr *trueMyFalse = [_sut truSubstitute:trueVal in:@"x" for:myFalse];
    TruExpr *falseXMyNot = [_sut truSubstitute:falseVal in:@"x" for:myNot];
    TruExpr *trueYMyXor =  [_sut truSubstitute:trueVal in:@"y" for:myXor];
    TruExpr *falseZMyMaj = [_sut truSubstitute:falseVal in:@"z" for:myMaj];
    
    // THEN
    XCTAssertEqual([_sut truSubstitute:trueVal in:@"x" for:falseVal], falseVal);
    XCTAssertEqual([_sut truSubstitute:trueVal in:@"x" for:x], trueVal);
    XCTAssertEqual([_sut truSubstitute:trueVal in:@"x" for:y], y);
    XCTAssertEqual([(TruValue*) [(TruNot*) notFalse expression] value], false);
    XCTAssertEqual([(TruId*)    [(TruAnd*) andTrueY rhs] name], @"y");
    XCTAssertEqual([(TruId*)    [(TruOr*) orXFalse lhs] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruNand*) nandTrueY rhs] name], @"y");
    XCTAssertEqual([(TruId*)    [(TruNor*) norXTrue lhs] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruXor*) xorFalseY rhs] name], @"y");
    XCTAssertEqual([(TruId*)    [(TruXnor*) xnorXFalse lhs] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruImply*) implyFalseY rhs] name], @"y");
    XCTAssertEqual([(TruId*)    [(TruXnor*) xnorXFalse lhs] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruEqual*) equalXTrue lhs] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruMaj*) majXYFalse first] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruMaj*) majXYFalse second] name], @"y");
    XCTAssertEqual([(TruCall*)  trueMyFalse function], @"my-false");
    XCTAssertEqual([(TruCall*)  falseXMyNot function], @"my-not");
    XCTAssertEqual([(TruValue*) [(TruCall*) falseXMyNot arguments][0] value], false);
    XCTAssertEqual([(TruCall*)  trueYMyXor function], @"my-xor");
    XCTAssertEqual([(TruId*)    [(TruCall*) trueYMyXor arguments][0] name], @"x");
    XCTAssertEqual([(TruCall*)  falseZMyMaj function], @"my-majority");
    XCTAssertEqual([(TruId*)    [(TruCall*) falseZMyMaj arguments][0] name], @"x");
    XCTAssertEqual([(TruId*)    [(TruCall*) falseZMyMaj arguments][1] name], @"y");
    XCTAssertNil([_sut truSubstitute:trueVal in:@"x" for:nil]);
}

- (void)testTruInterpret
{
    // GIVEN
    TruValue *falseVal = [[TruValue alloc] init:false];
    TruValue *trueVal =  [[TruValue alloc] init:true];
    TruId    *x =        [[TruId    alloc] init:@"x"];
    TruNot   *notTrue =  [[TruNot   alloc] init:trueVal];
    TruNot   *notFalse = [[TruNot   alloc] init:falseVal];
    TruAnd   *andFF =    [[TruAnd   alloc] initWithLhs:falseVal andRhs:falseVal];
    TruAnd   *andTF =    [[TruAnd   alloc] initWithLhs:trueVal andRhs:falseVal];
    TruAnd   *andTT =    [[TruAnd   alloc] initWithLhs:trueVal andRhs:trueVal];
    TruAnd   *andAnd =   [[TruAnd   alloc] initWithLhs:andTF andRhs:trueVal];
    TruOr    *orFF =     [[TruOr    alloc] initWithLhs:falseVal andRhs:falseVal];
    TruOr    *orTF =     [[TruOr    alloc] initWithLhs:trueVal andRhs:falseVal];
    TruOr    *orTT =     [[TruOr    alloc] initWithLhs:trueVal andRhs:trueVal];
    TruOr    *orOr =     [[TruOr    alloc] initWithLhs:orTF andRhs:falseVal];
    TruNand  *nandFF =   [[TruNand  alloc] initWithLhs:falseVal andRhs:falseVal];
    TruNand  *nandTF =   [[TruNand  alloc] initWithLhs:trueVal andRhs:falseVal];
    TruNand  *nandTT =   [[TruNand  alloc] initWithLhs:trueVal andRhs:trueVal];
    TruNand  *nandNand = [[TruNand  alloc] initWithLhs:nandTF andRhs:trueVal];
    TruNor   *norFF =    [[TruNor   alloc] initWithLhs:falseVal andRhs:falseVal];
    TruNor   *norTF =    [[TruNor   alloc] initWithLhs:trueVal andRhs:falseVal];
    TruNor   *norTT =    [[TruNor   alloc] initWithLhs:trueVal andRhs:trueVal];
    TruNor   *norNor =   [[TruNor   alloc] initWithLhs:norTF andRhs:trueVal];
    TruXor   *xorFF =    [[TruXor   alloc] initWithLhs:falseVal andRhs:falseVal];
    TruXor   *xorTF =    [[TruXor   alloc] initWithLhs:trueVal andRhs:falseVal];
    TruXor   *xorTT =    [[TruXor   alloc] initWithLhs:trueVal andRhs:trueVal];
    TruXor   *xorXOr =   [[TruXor   alloc] initWithLhs:xorTF andRhs:trueVal];
    TruXnor  *xnorFF =   [[TruXnor  alloc] initWithLhs:falseVal andRhs:falseVal];
    TruXnor  *xnorTF =   [[TruXnor  alloc] initWithLhs:trueVal andRhs:falseVal];
    TruXnor  *xnorTT =   [[TruXnor  alloc] initWithLhs:trueVal andRhs:trueVal];
    TruXnor  *xnorXnor = [[TruXnor  alloc] initWithLhs:xnorTF andRhs:trueVal];
    TruImply *implyFF =  [[TruImply alloc] initWithLhs:falseVal andRhs:falseVal];
    TruImply *implyTF =  [[TruImply alloc] initWithLhs:trueVal andRhs:falseVal];
    TruImply *implyTT =  [[TruImply alloc] initWithLhs:trueVal andRhs:trueVal];
    TruImply *impImply = [[TruImply alloc] initWithLhs:implyTF andRhs:trueVal];
    TruEqual *eqFF =     [[TruEqual alloc] initWithLhs:falseVal andRhs:falseVal];
    TruEqual *eqTF =     [[TruEqual alloc] initWithLhs:trueVal andRhs:falseVal];
    TruEqual *eqTT =     [[TruEqual alloc] initWithLhs:trueVal andRhs:trueVal];
    TruEqual *eqEq =     [[TruEqual alloc] initWithLhs:eqTF andRhs:trueVal];
    TruMaj *majFFF =     [[TruMaj   alloc] initWithFirst:falseVal second:falseVal andThird:falseVal];
    TruMaj *majTTT =     [[TruMaj   alloc] initWithFirst:trueVal second:trueVal andThird:trueVal];
    TruMaj *majFFT =     [[TruMaj   alloc] initWithFirst:falseVal second:falseVal andThird:trueVal];
    TruMaj *majMaj =     [[TruMaj   alloc] initWithFirst:majFFT second:trueVal andThird:falseVal];
    TruCall *myFalse =   [[TruCall  alloc] initWithFunction:@"my-false" andExpressions:nil];
    TruCall *myNot =     [[TruCall  alloc] initWithFunction:@"my-not" andExpressions:@[falseVal]];
    TruCall *myXor =     [[TruCall  alloc] initWithFunction:@"my-xor" andExpressions:@[trueVal, falseVal]];
    TruCall *myMaj =     [[TruCall  alloc] initWithFunction:@"my-majority" andExpressions:@[trueVal, trueVal, falseVal]];
    TruMaj *combined =   [[TruMaj alloc]
                          initWithFirst:[[TruEqual alloc] initWithLhs:implyFF andRhs:xnorTF]
                          second:[[TruXor alloc] initWithLhs:norTT andRhs:nandNand]
                          andThird:[[TruOr alloc] initWithLhs:andFF andRhs:notFalse]];

    // THEN
    XCTAssertEqual([_sut truInterpret:x withDefinitions:nil], NO); // TODO handling an error somehow, maybe having a second param as an error
    XCTAssertEqual([_sut truInterpret:falseVal withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:trueVal withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:notTrue withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:notFalse withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:andFF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:andTF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:andTT withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:andAnd withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:orFF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:orTF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:orTT withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:orOr withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:nandFF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:nandTF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:nandTT withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:nandNand withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:norFF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:norTF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:norTT withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:norNor withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:xorFF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:xorTF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:xorTT withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:xorXOr withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:xnorFF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:xnorTF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:xnorTT withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:xnorXnor withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:implyFF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:implyTF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:implyTT withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:impImply withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:eqFF withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:eqTF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:eqTT withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:eqEq withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:majFFF withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:majFFT withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:majTTT withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:majMaj withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:myFalse withDefinitions:nil], NO);
    XCTAssertEqual([_sut truInterpret:myNot withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:myXor withDefinitions:nil], YES);
    XCTAssertEqual([_sut truInterpret:myMaj withDefinitions:nil], YES);
}

@end
