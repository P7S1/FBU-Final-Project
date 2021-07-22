//
//  ListingItemViewController.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/21/21.
//

#import <UIKit/UIKit.h>
#import "ItemListing.h"
#import "ZoomTransitionController.h"
#import "ZoomAnimatorDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListingItemDetailViewController : UIViewController<ZoomAnimatorDelegate>

- (instancetype)initWithListing: (ItemListing*)listing;

@property (nonatomic, strong) ItemListing* item;
@property (nonatomic, strong) ZoomTransitionController* transitionController;

@end

NS_ASSUME_NONNULL_END
