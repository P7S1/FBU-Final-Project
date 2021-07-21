//
//  CategoryTableViewCell.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import <UIKit/UIKit.h>
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) NSArray<ItemListing*>* items;
@property (nonatomic, strong) UIViewController* presentingViewController;

- (void)reloadCollectionViewData;

@end

NS_ASSUME_NONNULL_END
