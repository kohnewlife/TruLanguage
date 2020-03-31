//
//  TruAnd.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "TruExpr.h"
#ifndef TruAnd_h
#define TruAnd_h

@interface TruAnd : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
- (id) initWithLhs:(TruExpr*) lhs andRhs:(TruExpr*) rhs;
@end

#endif /* TruAnd_h */
