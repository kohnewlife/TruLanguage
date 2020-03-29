//
//  TruAnd.h
//  TruLanguage
//
//  Created by Huy Vo on 3/27/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruAnd_h
#define TruAnd_h

@interface TruAnd : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

@implementation TruAnd
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

#endif /* TruAnd_h */
