//
//  TruMaj.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruMaj.h"


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
