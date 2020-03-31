//
//  TruImply.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//
#import "TruExpr.h"
#ifndef TruImply_h
#define TruImply_h

@interface TruImply : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

#endif /* TruImply_h */
