//
//  TruNot.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "TruExpr.h"
#ifndef TruNot_h
#define TruNot_h

@interface TruNot : TruExpr
@property TruExpr* expression;
- (id) init:(TruExpr*) expr;
@end

#endif /* TruNot_h */
