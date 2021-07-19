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

typedef void(^ListingCompletionBlock)(NSArray<ItemListing*> * _Nullable results, NSError * _Nullable error);

- (void)fetchAllListingsWithCompletion: (ListingCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
