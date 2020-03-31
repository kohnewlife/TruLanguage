//
//  TruNot.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruNot.h"

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
