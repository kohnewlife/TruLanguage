//
//  TruMaj.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//
#import "TruExpr.h"
#ifndef TruMaj_h
#define TruMaj_h


@interface TruMaj : TruExpr
@property TruExpr* first;
@property TruExpr* second;
@property TruExpr* third;
- (id) initWithFirst:(TruExpr*) first second:(TruExpr*) second andThird:(TruExpr*) third;
@end


#endif /* TruMaj_h */
