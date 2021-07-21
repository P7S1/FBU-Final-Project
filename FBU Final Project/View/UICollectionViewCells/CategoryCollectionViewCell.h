//
//  CategoryCollectionViewCell.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import <UIKit/UIKit.h>
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* itemImageView;

@property (nonatomic, strong) UIViewController* presentingViewController;
@property (nonatomic, strong) ItemListing* item;


@end

NS_ASSUME_NONNULL_END
