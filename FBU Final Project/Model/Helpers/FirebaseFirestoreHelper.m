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

+ (void)addSnapshotListenerWithCompletion:(ListingCompletionBlock)completion{
    FIRFirestore* db = [FIRFirestore firestore];
    
    [[[[db collectionWithPath:@"listings"] queryOrderedByField:@"endsInTimestamp" descending:YES] queryLimitedTo:20] addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        [FirebaseFirestoreHelper handleListingsWithSnapshot:snapshot withError:error withCompletion:completion];
    }];
}

+ (void)fetchListings:(ListingCompletionBlock)completion{
    FIRFirestore* db = [FIRFirestore firestore];
    [[[[db collectionWithPath:@"listings"] queryOrderedByField:@"endsInTimestamp" descending:YES] queryLimitedTo:20] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        [FirebaseFirestoreHelper handleListingsWithSnapshot:snapshot withError:error withCompletion:completion];
    }];
}

+ (void)handleListingsWithSnapshot: (FIRQuerySnapshot * _Nullable)snapshot withError: (NSError * _Nullable)error withCompletion:(ListingCompletionBlock)completion{
    if (error == nil){
        NSMutableArray<ItemListing*>* itemListings = [[NSMutableArray alloc]init];
        for (FIRDocumentSnapshot* document in [snapshot documents]){
            ItemListing* item = [[ItemListing alloc]initWithDict:[document data]];
            [itemListings addObject:item];
        }
        completion(itemListings,error);
    }else{
        completion(nil,error);
    }
}

@end
