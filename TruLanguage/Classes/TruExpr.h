//
//  TruExpr.h
//  TruLanguage
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//


#ifndef TruExpr_h
#define TruExpr_h

@interface TruExpr : NSObject
@end

@interface TruValue : TruExpr
@property BOOL value;
@end

@interface TruNot : TruExpr
@property TruExpr* expression;
@end

// TruAnd in TruAnd.h

// TruOr in TruAnd.h

// TruNand in TruAnd.h

@interface TruNor : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
@end

@interface TruXor : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
@end

@interface TruXnor : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
@end

@interface TruImply : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
@end

@interface TruEqual : TruExpr
@property TruExpr* lhs;
@property TruExpr* rhs;
@end

@interface TruMaj : TruExpr
@property TruExpr* first;
@property TruExpr* second;
@property TruExpr* third;
@end

@interface TruId : TruExpr
@property id name;
@end

@interface TruCall : TruExpr
@property NSString* function;
@property NSArray* expressions;
@end

#endif /* TruExpr_h */
