//
//  TruValue.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruValue.h"

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
