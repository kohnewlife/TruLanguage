//
//  TruId.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruId.h"

@implementation TruId
- (id)init:(NSString*)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}
@end
