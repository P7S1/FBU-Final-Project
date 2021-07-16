//
//  SwipableCardViewCard.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "SwipableViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@protocol SwipableViewDelegate;

@interface SwipableCardViewCard : UIView

@property (nonatomic, weak, nullable) id<SwipableViewDelegate> delegate;
@property (nonatomic, strong) CALayer* shadowLayer;

@end

NS_ASSUME_NONNULL_END
