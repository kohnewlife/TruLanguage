//
//  TruNor.h
//  TruLanguage
//
//  Created by Huy Vo on 3/28/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruNor_h
#define TruNor_h

@interface TruNor : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

@implementation TruNor
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

#endif /* TruNor_h */
