//
//  CartHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import "CartHelper.h"
#import "User.h"

@implementation CartHelper

+ (void)addItemToCart:(ItemListing *)item{
    FIRDocumentReference* ref = [[FIRFirestore firestore] documentWithPath:[@"listings/" stringByAppendingString:item.uid]];
    [ref setData:@{
        @"buyers":[FIRFieldValue fieldValueForArrayUnion:@[[User sharedInstance].uid]]
    } merge:YES];
}

@end
