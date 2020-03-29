//
//  TruValue.h
//  TruLanguage
//
//  Created by Huy Vo on 3/29/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruValue_h
#define TruValue_h

@interface TruValue : TruExpr
@property BOOL value;
- (id)init:(BOOL)value
@end

@implementation TruValue
- (id)init:(BOOL)value
{
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;
}
@end

#endif /* TruValue_h */
