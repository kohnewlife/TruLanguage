//
//  TruLanguageTests.m
//  TruLanguageTests
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

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
    TruDefinition *falsey = [[]]
    
    // WHEN
    <#code#>
    
    // THEN
    <#code#>
}

@end
