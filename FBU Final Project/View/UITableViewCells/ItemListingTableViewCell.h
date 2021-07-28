//
//  ItemListingTableViewCell.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import <UIKit/UIKit.h>
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemListingTableViewCell : UITableViewCell

- (void)setUpWithItemListing: (ItemListing*)item;

@end

NS_ASSUME_NONNULL_END
