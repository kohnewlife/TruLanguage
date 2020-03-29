//
//  TruNot.h
//  TruLanguage
//
//  Created by Huy Vo on 3/28/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruNot_h
#define TruNot_h

@interface TruNot : TruExpr
@property TruExpr* expression;
- (id) init:(TruExpr*) expr;
@end

@implementation TruNot
- (id)init:(TruExpr*)expr
{
    self = [super init];
    if (self) {
        self.expression = expr;
    }
    return self;
}
@end

#endif /* TruNot_h */
