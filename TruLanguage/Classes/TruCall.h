//
//  TruCall.h
//  TruLanguage
//
//  Created by Huy Vo on 3/28/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruCall_h
#define TruCall_h

@interface TruCall : TruExpr
@property NSString* function;
@property NSArray* arguments;
- (id) initWithFunction:(NSString*) function andExpressions:(NSArray*) arguments;
@end

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

#endif /* TruCall_h */
