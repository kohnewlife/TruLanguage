//
//  TruEqual.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//
#import "TruExpr.h"
#ifndef TruEqual_h
#define TruEqual_h

@interface TruEqual : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

#endif /* TruEqual_h */
