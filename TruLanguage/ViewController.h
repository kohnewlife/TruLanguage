//
//  ViewController.h
//  TruLanguage
//
//  Created by Huy Vo on 3/25/20.
//  Copyright © 2020 Huy Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TruExpr.h"
#import "TruValue.h"
#import "TruId.h"
#import "TruNot.h"
#import "TruAnd.h"
#import "TruOr.h"
#import "TruNand.h"
#import "TruNor.h"
#import "TruXor.h"
#import "TruXnor.h"
#import "TruImply.h"
#import "TruMaj.h"
#import "TruEqual.h"
#import "TruCall.h"
#import "TruDefinition.h"
#import "TruFunction.h"


@interface ViewController : UIViewController

- (TruDefinition*) truLookup:(NSString*) func with:(NSArray*) definitions;
- (TruExpr*) truSubstitute:(TruExpr*) expr in:(NSString*) symbol for:(TruExpr*) newExpr;
- (BOOL)truInterpret:(TruExpr*)expression withDefinitions:(NSArray*)defs;

@end



//
//; VARIABLES TruExpr
//
//; VARIABLES TruDefinition
//(module+ test
//  (define sample-tru-def0 (tru-function0 'my-false
//                                         (tru-value #f))) ; 0 parameters
//  (define sample-tru-def1 (tru-function1 'my-not 'false   ; 1 argument
//                                         (tru-not (tru-value #f))))
//  (define sample-tru-def2 (tru-function2 'my-xor 'a 'b    ; 2 parameters
//                                         (tru-parse-expression `{and {or a b} {not {and a b}}})))
//  (define sample-tru-def3 (tru-function3 'my-majority 'a 'b 'c ; 3 parameters
//                                         (tru-parse-expression `{or {or
//                                                                     {and a b}
//                                                                     {and a c}}
//                                                                    {and  b c}}))))


//
//; TESTS tru-interpret
//(module+ test
//  (test (tru-interpret sample-tru-value1 empty) #f)
//  (test (tru-interpret sample-tru-value2 empty) #t)
//  (test (tru-interpret sample-tru-not1   empty) #f)
//  (test (tru-interpret sample-tru-not2   empty) #t)
//  (test (tru-interpret sample-tru-and1   empty) #f)
//  (test (tru-interpret sample-tru-and2   empty) #f)
//  (test (tru-interpret sample-tru-and3   empty) #t)
//  (test (tru-interpret sample-tru-and4   empty) #f)
//  (test (tru-interpret sample-tru-or1    empty) #f)
//  (test (tru-interpret sample-tru-or2    empty) #t)
//  (test (tru-interpret sample-tru-or3    empty) #t)
//  (test (tru-interpret sample-tru-or4    empty) #t)
//  (test (tru-interpret sample-tru-nand1  empty) #t)
//  (test (tru-interpret sample-tru-nand2  empty) #t)
//  (test (tru-interpret sample-tru-nand3  empty) #f)
//  (test (tru-interpret sample-tru-nand4  empty) #f)
//  (test (tru-interpret sample-tru-nor1   empty) #t)
//  (test (tru-interpret sample-tru-nor2   empty) #f)
//  (test (tru-interpret sample-tru-nor3   empty) #f)
//  (test (tru-interpret sample-tru-nor4   empty) #f)
//  (test (tru-interpret sample-tru-xor1   empty) #f)
//  (test (tru-interpret sample-tru-xor2   empty) #t)
//  (test (tru-interpret sample-tru-xor3   empty) #f)
//  (test (tru-interpret sample-tru-xor4   empty) #f)
//  (test (tru-interpret sample-tru-xnor1  empty) #t)
//  (test (tru-interpret sample-tru-xnor2  empty) #f)
//  (test (tru-interpret sample-tru-xnor3  empty) #t)
//  (test (tru-interpret sample-tru-xnor4  empty) #f)
//  (test (tru-interpret sample-tru-imply1 empty) #t)
//  (test (tru-interpret sample-tru-imply2 empty) #f)
//  (test (tru-interpret sample-tru-imply3 empty) #t)
//  (test (tru-interpret sample-tru-imply4 empty) #t)
//  (test (tru-interpret sample-tru-eq1    empty) #t)
//  (test (tru-interpret sample-tru-eq2    empty) #f)
//  (test (tru-interpret sample-tru-eq3    empty) #t)
//  (test (tru-interpret sample-tru-eq4    empty) #f)
//  (test (tru-interpret sample-tru-maj1   empty) #f)
//  (test (tru-interpret sample-tru-maj2   empty) #t)
//  (test (tru-interpret sample-tru-maj3   empty) #f)
//  (test (tru-interpret sample-tru-maj4   empty) #t)
//  (test/exn (tru-interpret sample-tru-id empty) "tru-interpret: unbound name")
//  (test (tru-interpret sample-tru-call0  (list sample-tru-def0)) #f)
//  (test (tru-interpret sample-tru-call1  (list sample-tru-def1)) #t)
//  (test (tru-interpret sample-tru-call2  (list sample-tru-def2)) #t)
//  (test (tru-interpret sample-tru-call3  (list sample-tru-def3)) #t))
