//
//  FirebaseFirestoreHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import "FirebaseFirestoreHelper.h"
#import "ItemListing.h"

@implementation FirebaseFirestoreHelper

- (void)fetchAllListingsWithCompletion:(ListingCompletionBlock)completion{
    FIRFirestore* db = [FIRFirestore firestore];
    [[[db collectionWithPath:@"listings"] queryLimitedTo:20] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
    }];
}

@end
