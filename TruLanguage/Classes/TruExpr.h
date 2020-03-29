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

@interface TruId : TruExpr
@property id name;
@end

#endif /* TruExpr_h */
