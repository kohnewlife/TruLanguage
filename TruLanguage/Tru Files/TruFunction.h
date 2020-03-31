//
//  TruFunction.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//
#import "TruDefinition.h"
#import "TruExpr.h"
#ifndef TruFunction_h
#define TruFunction_h





@interface TruFunction : TruDefinition
@property NSString* name;
@property NSArray* parameters;
@property TruExpr* body;
- (id) initWithName:(NSString*) name parameters:(NSArray*) parameters andBody:(TruExpr*) body;
@end


#endif /* TruFunction_h */
