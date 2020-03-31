//
//  TruId.h
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import "TruExpr.h"
#ifndef TruId_h
#define TruId_h

@interface TruId : TruExpr
@property NSString *name;
- (id)init:(NSString*)name;
@end

#endif /* TruId_h */
