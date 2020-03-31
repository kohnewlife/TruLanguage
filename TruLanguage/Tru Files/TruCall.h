//
//  TruCall.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//
#import "TruExpr.h"
#ifndef TruCall_h
#define TruCall_h



@interface TruCall : TruExpr
@property NSString* function;
@property NSArray* arguments;
- (id) initWithFunction:(NSString*) function andExpressions:(NSArray*) arguments;
@end


#endif /* TruCall_h */
