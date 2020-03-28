//
//  TruDefinition.h
//  TruLanguage
//
//  Created by Huy Vo on 3/26/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#ifndef TruDefinition_h
#define TruDefinition_h


@interface TruDefinition
@end

@interface TruFunction
@property NSString name;
@property NSArray arguments;
@property TruExpr body;
@end


#endif /* TruDefinition_h */
