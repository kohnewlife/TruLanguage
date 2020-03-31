//
//  TruValue.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "TruExpr.h"
#ifndef TruValue_h
#define TruValue_h

@interface TruValue : TruExpr
@property BOOL value;
- (id)init:(BOOL)value;
@end

#endif /* TruValue_h */
