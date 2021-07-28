//
//  SwipableCardViewCard.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "SwipableViewDelegate.h"
#import "ItemListing.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SwipableViewDelegate;

@interface SwipableCardViewCard : UIView

@property (nonatomic, weak, nullable) id<SwipableViewDelegate> delegate;

@property (nonatomic, strong, nullable) ItemListing* itemListing;

@property (nonatomic, strong) CALayer* shadowLayer;
@property (nonatomic, strong) UILabel* numberLabel;

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* itemImageView;
@property (nonatomic, strong) UIImageView* backgroundImageView;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) UILabel* dateLabel;

@end

NS_ASSUME_NONNULL_END
