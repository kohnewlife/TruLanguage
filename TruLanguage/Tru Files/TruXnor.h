//
//  TruXnor.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "TruExpr.h"
#ifndef TruXnor_h
#define TruXnor_h

@interface TruXnor : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

#endif /* TruXnor_h */
