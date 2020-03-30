//
//  TruFunction.h
//  TruLanguage
//
//  Created by Huy Vo on 3/29/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruFunction_h
#define TruFunction_h

@interface TruFunction : TruDefinition
@property NSString* name;
@property NSArray* parameters;
@property TruExpr* body;
- (id) initWithName:(NSString*) name parameters:(NSArray*) parameters andBody:(TruExpr*) body;
@end

@implementation TruFunction

- (id) initWithName:(NSString*) name parameters:(NSArray*) parameters andBody:(TruExpr*) body
{
    self = [super init];
    if (self) {
        self.name = name;
        self.parameters = parameters;
        self.body = body;
    }
    return self;
}

@end

#endif /* TruFunction_h */
