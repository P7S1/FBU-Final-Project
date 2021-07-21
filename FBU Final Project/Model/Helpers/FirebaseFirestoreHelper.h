//
//  FirebaseFirestoreHelper.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import <Foundation/Foundation.h>
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirebaseFirestoreHelper : NSObject

typedef void(^ListingCompletionBlock)(NSArray<ItemListing*>* _Nullable results, NSError * _Nullable error);

+ (void)addSnapshotListenerWithCompletion: (ListingCompletionBlock)completion;
+ (void)fetchListings:(ListingCompletionBlock)completion;
+ (void)handleListingsWithSnapshot: (FIRQuerySnapshot * _Nullable)snapshot withError: (NSError * _Nullable)error withCompletion:(ListingCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
