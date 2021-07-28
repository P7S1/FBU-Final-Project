//
//  CartHelper.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import <Foundation/Foundation.h>
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartHelper : NSObject

+ (void)addItemToCart: (ItemListing*)item;

@end

NS_ASSUME_NONNULL_END
