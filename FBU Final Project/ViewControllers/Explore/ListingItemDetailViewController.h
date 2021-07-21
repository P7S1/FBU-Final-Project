//
//  ListingItemViewController.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/21/21.
//

#import <UIKit/UIKit.h>
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListingItemDetailViewController : UIViewController

@property (nonatomic, strong) ItemListing* item;

@end

NS_ASSUME_NONNULL_END
