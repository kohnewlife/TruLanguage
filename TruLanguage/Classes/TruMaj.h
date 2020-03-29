//
//  TruMaj.h
//  TruLanguage
//
//  Created by Huy Vo on 3/28/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruMaj_h
#define TruMaj_h

@interface TruMaj : TruExpr
@property TruExpr* first;
@property TruExpr* second;
@property TruExpr* third;
- (id) initWithFirst:(TruExpr*) first second:(TruExpr*) second andThird:(TruExpr*) third;
@end

@implementation TruMaj
- (id) initWithFirst:(TruExpr*) first second:(TruExpr*) second andThird:(TruExpr*) third;
{
    self = [super init];
    if (self) {
        self.first = first;
        self.second = second;
        self.third = third;
    }
    return self;
}
@end

#endif /* TruMaj_h */
