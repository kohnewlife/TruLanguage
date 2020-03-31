//
//  TruCall.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruCall.h"


@implementation TruCall
- (id) initWithFunction:(NSString*) function andExpressions:(NSArray*) arguments;
{
    self = [super init];
    if (self) {
        self.function = function;
        self.arguments = arguments;
    }
    return self;
}
@end
