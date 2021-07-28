//
//  CartHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import "CartHelper.h"

@implementation CartHelper

+ (void)addItemToCart:(ItemListing *)item{
    FIRDocumentReference* ref = [[FIRFirestore firestore] documentWithPath:[@"listings/" stringByAppendingString:item.uid]];
    [ref setData:@{
        @"buyers":[FIRFieldValue fieldValueForArrayUnion:@[item.uid]]
    } merge:YES];
}

@end
