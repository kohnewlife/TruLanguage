//
//  TruFunction.m
//  TruLanguage
//
//  Created by Huy Vo on 3/30/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruFunction.h"

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

