//
//  TruOr.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruOr.h"

@implementation TruOr
- (id)initWithLhs:(TruExpr*)lhs andRhs:(TruExpr*)rhs
{
    self = [super init];
    if (self) {
        self.lhs = lhs;
        self.rhs = rhs;
    }
    return self;
}
@end
