//
//  TruXor.h
//  TruLanguage
//
//  Created by Huy Vo on 3/28/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruXor_h
#define TruXor_h

@interface TruXor : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

@implementation TruXor
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

#endif /* TruXor_h */
