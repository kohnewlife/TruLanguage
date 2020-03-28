//
//  TruNand.h
//  TruLanguage
//
//  Created by Huy Vo on 3/28/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruNand_h
#define TruNand_h

@interface TruNand : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

@implementation TruNand
- (id)initWithLhs:(id)lhs andRhs:(id)rhs
{
    self = [super init];
    if (self) {
        self.lhs = lhs;
        self.rhs = rhs;
    }
    return self;
}
@end

#endif /* TruNand_h */
