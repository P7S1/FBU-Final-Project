//
//  ItemListing.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/15/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseFirestore/FirebaseFirestore.h>
#import "ItemListing.h"
#import "FirestoreObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemListing: FirestoreObject

@property (nonatomic, strong) NSString* creatorUid;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic) CGFloat price;

@property (nonatomic) NSInteger quantity;
@property (nonatomic) FIRTimestamp* endsInTimestamp;
@property (nonatomic, strong) NSString* location;
@property (nonatomic) NSInteger category;
@property (nonatomic, strong) NSArray<NSString*>* buyers;

@end

NS_ASSUME_NONNULL_END
